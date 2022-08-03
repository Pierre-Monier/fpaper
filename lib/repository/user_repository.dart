import 'package:auth/model/auth_user.dart';
import 'package:core/model/user.dart';
import 'package:db/data/source/firestore_datasource.dart';
import 'package:fpaper/util/memory_store.dart';

class UserRepository {
  const UserRepository({
    required FirestoreDatasource firestoreDatasource,
    required InMemoryStore<User?> userStore,
  })  : _firestoreDatasource = firestoreDatasource,
        _userStore = userStore;

  static const _defaultUsername = "Unknown";

  final FirestoreDatasource _firestoreDatasource;
  final InMemoryStore<User?> _userStore;

  Future<void> getOrCreateUser(AuthUser authUser) async {
    final userInDb = await _getUser(authUser);
    final userData = userInDb ?? await _createUser(authUser);
    final user = _userFromMap(userData);
    _userStore.value = user;
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

  User _userFromMap(Map<String, dynamic> map) => User(
        id: "id",
        username: map["username"] as String? ?? _defaultUsername,
        devices: [],
        friends: [],
        pullHistoryData: [],
        pushHistoryData: [],
        profilPicturePath: map["profilPicturePath"] as String?,
      );

  User? get currentUser => _userStore.value;
  Stream<User?> get watchUser => _userStore.watch;
}
