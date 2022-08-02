import 'package:auth/data/repository/auth_cancelled_exception.dart';
import 'package:auth/data/repository/auth_failed_exception.dart';
import 'package:auth/data/repository/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock/class.dart';
import '../../mock/data.dart';

void main() {
  setUpAll(() {
    when(() => mockUserCredential.user).thenReturn(mockFirebaseUser);
    when(() => mockFirebaseUser.uid).thenReturn(mockUID);
    when(
      () => mockFirebaseAuthDatasource.signUserWithGithub(
        token: mockGithubToken,
      ),
    ).thenAnswer((_) {
      return Future.value(mockFirebaseUser);
    });
    when(
      () => mockFirebaseAuthDatasource.signUserWithGoogle(
        accessToken: mockGoogleAccessToken,
        idToken: mockGoogleIdToken,
      ),
    ).thenAnswer((_) {
      return Future.value(mockFirebaseUser);
    });
    when(
      mockFirebaseAuthDatasource.signOut,
    ).thenAnswer((_) async {
      return Future.value();
    });
  });

  test('it should be able to signOut', () async {
    final authRepository = AuthRepository(
      firebaseAuthDatasource: mockFirebaseAuthDatasource,
    );

    // ! toddo should expose firebaseAuthStream and expect later that null is emited
    // await authRepository.signUserAnonymously(); // user is signIn
    await authRepository.signOut();

    // final user = authRepository.user;

    // expect(user, null);
  });

  test('it should be able to sign in with github', () async {
    final authRepository = AuthRepository(
      firebaseAuthDatasource: mockFirebaseAuthDatasource,
    );
    final user =
        await authRepository.signUserWithGithub(token: mockGithubToken);

    expect(user.uid, mockAuthUser.uid);
  });

  test(
    'it should throw a AuthFailedException'
    ' if github sign in get a null token parameter',
    () {
      final authRepository = AuthRepository(
        firebaseAuthDatasource: mockFirebaseAuthDatasource,
      );

      when(
        () => mockFirebaseAuthDatasource.signUserWithGithub(
          token: mockGithubToken,
        ),
      ).thenAnswer((_) {
        return Future.value();
      });

      expect(
        () async => authRepository.signUserWithGithub(token: mockGithubToken),
        throwsA(isA<AuthFailedException>()),
      );
    },
  );

  test(
    'it should throw a AuthCancelledException on github sign in'
    ' if firebase datasource return a null user',
    () {
      final authRepository = AuthRepository(
        firebaseAuthDatasource: mockFirebaseAuthDatasource,
      );

      expect(
        () async => authRepository.signUserWithGithub(token: null),
        throwsA(isA<AuthCancelledException>()),
      );
    },
  );

  test('it should be able to sign in with google', () async {
    final authRepository = AuthRepository(
      firebaseAuthDatasource: mockFirebaseAuthDatasource,
    );

    final user = await authRepository.signUserWithGoogle(
      accessToken: mockGoogleAccessToken,
      idToken: mockGoogleIdToken,
    );

    expect(user.uid, mockAuthUser.uid);
  });

  test(
    'it should throw a SignInReturnNullException'
    ' if google sign in get a null accessToken parameter or'
    ' a null idToken parameter',
    () {
      final authRepository = AuthRepository(
        firebaseAuthDatasource: mockFirebaseAuthDatasource,
      );

      expect(
        () async => authRepository.signUserWithGoogle(
          accessToken: null,
          idToken: null,
        ),
        throwsA(isA<AuthCancelledException>()),
      );
    },
  );

  test(
    'it should throw a AuthFailedException on google sign in'
    ' if firebase datasource return a null user',
    () {
      final authRepository = AuthRepository(
        firebaseAuthDatasource: mockFirebaseAuthDatasource,
      );

      when(
        () => mockFirebaseAuthDatasource.signUserWithGoogle(
          accessToken: mockGoogleAccessToken,
          idToken: mockGoogleIdToken,
        ),
      ).thenAnswer((_) {
        return Future.value();
      });

      expect(
        () async => authRepository.signUserWithGoogle(
          accessToken: mockGoogleAccessToken,
          idToken: mockGoogleIdToken,
        ),
        throwsA(isA<AuthFailedException>()),
      );
    },
  );
}
