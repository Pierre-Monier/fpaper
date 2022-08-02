import 'package:auth/data/source/firebase_auth_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock/class.dart';
import '../../mock/data.dart';

void main() {
  final firebaseAuthDatasource =
      FirebaseAuthDataSource(firebaseAuth: mockFirebaseAuth);

  setUpAll(() {
    registerFallbackValue(OAuthCredentialFake());
    when(() => mockUserCredential.user).thenReturn(mockFirebaseUser);
    when(mockFirebaseAuth.signInAnonymously)
        .thenAnswer((_) => Future.value(mockUserCredential));
    when(
      () => mockFirebaseAuth.signInWithCredential(
        any(),
      ),
    ).thenAnswer((_) => Future.value(mockUserCredential));
    when(mockFirebaseAuth.signOut).thenAnswer((_) => Future.value());
    when(() => mockFirebaseAuth.currentUser).thenReturn(mockFirebaseUser);
  });

  test('it should be able to sign in with github', () async {
    final user =
        await firebaseAuthDatasource.signUserWithGithub(token: mockGithubToken);

    expect(user, mockFirebaseUser);
  });

  test('it should be able to sign in with google', () async {
    final user = await firebaseAuthDatasource.signUserWithGoogle(
      accessToken: mockGoogleAccessToken,
      idToken: mockGoogleIdToken,
    );

    expect(user, mockFirebaseUser);
  });

  test('it should be able to sign out', () async {
    await firebaseAuthDatasource.signOut();

    verify(mockFirebaseAuth.signOut).called(1);
  });
}
