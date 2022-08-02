import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthDataSource {
  const FirebaseAuthDataSource({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  final FirebaseAuth _firebaseAuth;

  Future<User?> signUserWithGithub({required String token}) async {
    final githubAuthCredential = GithubAuthProvider.credential(token);
    final userCredential =
        await _firebaseAuth.signInWithCredential(githubAuthCredential);

    return userCredential.user;
  }

  Future<User?> signUserWithGoogle({
    required String accessToken,
    required String idToken,
  }) async {
    final googleCredential = GoogleAuthProvider.credential(
      accessToken: accessToken,
      idToken: idToken,
    );

    final userCredential =
        await _firebaseAuth.signInWithCredential(googleCredential);

    return userCredential.user;
  }

  Future<void> signOut() => _firebaseAuth.signOut();

  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
}
