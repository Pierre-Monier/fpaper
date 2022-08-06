import 'package:auth/data/repository/auth_cancelled_exception.dart';
import 'package:auth/data/repository/auth_failed_exception.dart';
import 'package:auth/data/repository/auth_repository.dart';
import 'package:auth/model/auth_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock/class.dart';
import '../../mock/data.dart';

final createAuthUser = predicate<AuthUser>(
  (authUser) {
    return authUser.uid == mockAuthUser.uid;
  },
);

void main() {
  setUpAll(() {
    when(() => mockUserCredential.user).thenReturn(mockFirebaseUser);
    when(() => mockFirebaseUser.uid).thenReturn(mockUID);
    when(
      () => mockFirebaseAuthDatasource.signUserWithGithub(
        token: mockGithubToken,
      ),
    ).thenAnswer((_) {
      mockFirebaseAuthDataChange.add(mockFirebaseUser);
      return Future.value(mockFirebaseUser);
    });
    when(
      () => mockFirebaseAuthDatasource.signUserWithGoogle(
        accessToken: mockGoogleAccessToken,
        idToken: mockGoogleIdToken,
      ),
    ).thenAnswer((_) {
      mockFirebaseAuthDataChange.add(mockFirebaseUser);
      return Future.value(mockFirebaseUser);
    });
    when(
      mockFirebaseAuthDatasource.signOut,
    ).thenAnswer((_) async {
      mockFirebaseAuthDataChange.add(null);
      return Future.value();
    });
    when(() => mockFirebaseAuthDatasource.authStateChanges)
        .thenAnswer((_) => mockFirebaseAuthDataChange);
  });

  test('it should be able to signOut', () async {
    final authRepository = AuthRepository(
      firebaseAuthDatasource: mockFirebaseAuthDatasource,
    );

    await authRepository.signOut();
    expectLater(authRepository.authUserStream, emits(null));
  });

  test('it should be able to sign in with github', () async {
    final authRepository = AuthRepository(
      firebaseAuthDatasource: mockFirebaseAuthDatasource,
    );
    await authRepository.signUserWithGithub(token: mockGithubToken);

    expectLater(
      authRepository.authUserStream,
      emits(
        createAuthUser,
      ),
    );
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

    await authRepository.signUserWithGoogle(
      accessToken: mockGoogleAccessToken,
      idToken: mockGoogleIdToken,
    );

    expectLater(authRepository.authUserStream, emits(createAuthUser));
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
