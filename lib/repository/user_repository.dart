import 'package:auth/model/auth_user.dart';
import 'package:db/data/source/firestore_datasource.dart';

class UserRepository {
  const UserRepository({required FirestoreDatasource firestoreDatasource})
      : _firestoreDatasource = firestoreDatasource;

  final FirestoreDatasource _firestoreDatasource;

  Future<void> getOrCreateUser(AuthUser authUser) async {
    final userInDb = await _getUser(authUser);
    final user = userInDb ?? await _createUser(authUser);
    // * set user in memory store
  }

  /// it try to get user from db
  Future<Map<String, dynamic>?> _getUser(AuthUser authUser) {
    return _firestoreDatasource.getUserById(id: authUser.uid);
  }

  Future<Map<String, dynamic>> _createUser(AuthUser authUser) {
    return _firestoreDatasource.createUser(
      data: _authUserToMap(authUser),
      id: authUser.uid,
    );
  }

  Map<String, dynamic> _authUserToMap(AuthUser authUser) {
    return {
      "username": authUser.username,
      "profilePicturesPath": authUser.profilePicturesPath,
    };
  }
}
