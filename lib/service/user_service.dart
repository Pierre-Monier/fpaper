import 'package:auth/data/repository/auth_repository.dart';
import 'package:core/model/user.dart';
import 'package:fpaper/data/repository/user_repository.dart';
import 'package:fpaper/util/memory_store.dart';

class UserService {
  UserService({
    required UserRepository userRepository,
    required AuthRepository authRepository,
    required InMemoryStore<User?> userStore,
  })  : _userRepository = userRepository,
        _authRepository = authRepository,
        _userStore = userStore {
    _authRepository.authUserStream.listen((authUser) async {
      if (authUser != null) {
        final user = await _userRepository.getOrCreateUser(authUser);
        _userStore.value = user;
      } else {
        _userStore.value = null;
      }
    });
  }

  final UserRepository _userRepository;
  final AuthRepository _authRepository;
  final InMemoryStore<User?> _userStore;

  Future<void> loginWithGoogle({
    required String? accessToken,
    required String? idToken,
  }) async {
    await _authRepository.signUserWithGoogle(
      accessToken: accessToken,
      idToken: idToken,
    );
  }

  Future<void> loginWithGithub({required String? token}) async {
    await _authRepository.signUserWithGithub(token: token);
  }

  Future<void> signOut() => _authRepository.signOut();

  User? get currentUser => _userStore.value;
  Stream<User?> get watchUser => _userStore.watch;
}
