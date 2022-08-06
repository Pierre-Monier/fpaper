import 'package:core/model/user.dart';
import 'package:fpaper/repository/user_repository.dart';
import 'package:fpaper/util/memory_store.dart';

class UserService {
  const UserService({
    required UserRepository userRepository,
    required InMemoryStore<User?> userStore,
  })  : _userRepository = userRepository,
        _userStore = userStore;

  final UserRepository _userRepository;
  final InMemoryStore<User?> _userStore;

  User? get currentUser => _userStore.value;
  Stream<User?> get watchUser => _userStore.watch;
}
