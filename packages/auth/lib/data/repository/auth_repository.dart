import 'package:auth/data/repository/auth_cancelled_exception.dart';
import 'package:auth/data/repository/auth_failed_exception.dart';
import 'package:auth/data/source/firebase_auth_datasource.dart';
import 'package:auth/model/auth_user.dart';

class AuthRepository {
  AuthRepository({
    required FirebaseAuthDataSource firebaseAuthDatasource,
  }) : _firebaseAuthDatasource = firebaseAuthDatasource;

  final FirebaseAuthDataSource _firebaseAuthDatasource;

  Future<void> signUserWithGithub({required String? token}) =>
      _withExceptionCatch(() async {
        if (token == null) {
          throw AuthCancelledException();
        }

        final firebaseGithubUser =
            await _firebaseAuthDatasource.signUserWithGithub(token: token);

        if (firebaseGithubUser == null) {
          throw AuthFailedException();
        }
      });

  Future<void> signUserWithGoogle({
    required String? accessToken,
    required String? idToken,
  }) =>
      _withExceptionCatch(() async {
        if (accessToken == null || idToken == null) {
          throw AuthCancelledException();
        }

        final firebaseGoogleUser = await _firebaseAuthDatasource
            .signUserWithGoogle(accessToken: accessToken, idToken: idToken);

        if (firebaseGoogleUser == null) {
          throw AuthFailedException();
        }
      });

  Future<void> signOut() => _firebaseAuthDatasource.signOut();

  Future<void> _withExceptionCatch(
    Future<void> Function() authCallback,
  ) {
    try {
      return authCallback();
    } on AuthCancelledException {
      rethrow;
    } on Exception {
      throw AuthFailedException;
    }
  }

  Stream<AuthUser?> get authUserStream =>
      _firebaseAuthDatasource.authStateChanges.map((user) {
        if (user != null) {
          return AuthUser(
            uid: user.uid,
            username: user.displayName,
            profilePicturesPath: user.photoURL,
          );
        }
        return null;
      });
}
