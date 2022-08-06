import 'package:auth/data/repository/auth_repository.dart';
import 'package:core/model/user.dart';
import 'package:fpaper/data/repository/user_repository.dart';
import 'package:fpaper/util/memory_store.dart';

class UserService {
  const UserService({
    required UserRepository userRepository,
    required AuthRepository authRepository,
    required InMemoryStore<User?> userStore,
  })  : _userRepository = userRepository,
        _authRepository = authRepository,
        _userStore = userStore;

  final UserRepository _userRepository;
  final AuthRepository _authRepository;
  final InMemoryStore<User?> _userStore;

  Future<void> loginWithGoogle({
    required String? accessToken,
    required String? idToken,
  }) async {
    final authUser = await _authRepository.signUserWithGoogle(
      accessToken: accessToken,
      idToken: idToken,
    );
    final user = await _userRepository.getOrCreateUser(authUser);
    _userStore.value = user;
  }

  Future<void> loginWithGithub({required String? token}) {
    return Future.value();
  }

  User? get currentUser => _userStore.value;
  Stream<User?> get watchUser => _userStore.watch;
}
