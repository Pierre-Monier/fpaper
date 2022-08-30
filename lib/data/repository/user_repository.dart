import 'package:auth/model/auth_user.dart';
import 'package:core/model/user.dart';
import 'package:db/data/source/firestore_datasource.dart';
import 'package:flutter/material.dart';
import 'package:fpaper/data/dto/user_dto.dart';

class UserRepository {
  const UserRepository({
    required FirestoreDatasource firestoreDatasource,
  }) : _firestoreDatasource = firestoreDatasource;

  final FirestoreDatasource _firestoreDatasource;

  Future<User> getOrCreateUser(AuthUser authUser) async {
    final userInDb = await _getUser(authUser);
    final userData = userInDb ?? await _createUser(authUser);
    final user = UserDto.fromMap({...userData, 'id': authUser.uid});
    return user;
  }

  /// it try to get user from db
  Future<Map<String, dynamic>?> _getUser(AuthUser authUser) {
    return _firestoreDatasource.getUserById(id: authUser.uid);
  }

  Future<Map<String, dynamic>> _createUser(AuthUser authUser) {
    return _firestoreDatasource.createUser(
      data: authUserToMap(authUser),
      id: authUser.uid,
    );
  }

  @visibleForTesting
  Map<String, dynamic> authUserToMap(AuthUser authUser) {
    return {
      "username": authUser.username,
      "profilePicturesPath": authUser.profilePicturesPath,
    };
  }
}
