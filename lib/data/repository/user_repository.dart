import 'package:auth/model/auth_user.dart';
import 'package:core/model/user.dart';
import 'package:db/data/source/firestore_datasource.dart';
import 'package:flutter/material.dart';

class UserRepository {
  const UserRepository({
    required FirestoreDatasource firestoreDatasource,
  }) : _firestoreDatasource = firestoreDatasource;

  static const _defaultUsername = "Unknown";

  final FirestoreDatasource _firestoreDatasource;

  Future<User> getOrCreateUser(AuthUser authUser) async {
    final userInDb = await _getUser(authUser);
    final userData = userInDb ?? await _createUser(authUser);
    final user = _userFromMap(userData, authUser.uid);
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

  User _userFromMap(Map<String, dynamic> map, String userId) => User(
        id: userId,
        username: map["username"] as String? ?? _defaultUsername,
        devices: [],
        friends: [],
        pullHistoryData: [],
        pushHistoryData: [],
        profilPicturePath: map["profilPicturePath"] as String?,
      );
}
