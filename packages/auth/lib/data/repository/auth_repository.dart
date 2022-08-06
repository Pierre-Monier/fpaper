import 'package:auth/data/repository/auth_cancelled_exception.dart';
import 'package:auth/data/repository/auth_failed_exception.dart';
import 'package:auth/data/source/firebase_auth_datasource.dart';
import 'package:auth/model/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  AuthRepository({
    required FirebaseAuthDataSource firebaseAuthDatasource,
  }) : _firebaseAuthDatasource = firebaseAuthDatasource;

  final FirebaseAuthDataSource _firebaseAuthDatasource;

  Future<AuthUser> signUserWithGithub({required String? token}) =>
      _withExceptionCatch(() async {
        if (token == null) {
          throw AuthCancelledException();
        }

        final firebaseGithubUser =
            await _firebaseAuthDatasource.signUserWithGithub(token: token);

        if (firebaseGithubUser == null) {
          throw AuthFailedException();
        }

        final authUser = AuthUser(
          uid: firebaseGithubUser.uid,
          username: firebaseGithubUser.displayName,
          profilePicturesPath: firebaseGithubUser.photoURL,
        );

        return authUser;
      });

  Future<AuthUser> signUserWithGoogle({
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

        final authUser = AuthUser(
          uid: firebaseGoogleUser.uid,
          username: firebaseGoogleUser.displayName,
          profilePicturesPath: firebaseGoogleUser.photoURL,
        );

        return authUser;
      });

  Future<void> signOut() => _firebaseAuthDatasource.signOut();

  Future<AuthUser> _withExceptionCatch(
    Future<AuthUser> Function() authCallback,
  ) {
    try {
      return authCallback();
    } on AuthCancelledException {
      rethrow;
    } on Exception {
      throw AuthFailedException;
    }
  }

  Stream<AuthUser> get authUserStream =>
      _firebaseAuthDatasource.authStateChanges
          .where((user) => user != null)
          .cast<User>()
          .map(
            (nonNullUser) => AuthUser(
              uid: nonNullUser.uid,
              username: nonNullUser.displayName,
              profilePicturesPath: nonNullUser.photoURL,
            ),
          );
}
