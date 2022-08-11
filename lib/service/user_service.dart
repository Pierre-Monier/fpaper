import 'package:auth/data/repository/auth_repository.dart';
import 'package:auth/model/auth_user.dart';
import 'package:core/model/user.dart';
import 'package:device_info/data/source/device_info_datasource.dart';
import 'package:fpaper/data/repository/device_repository.dart';
import 'package:fpaper/data/repository/user_repository.dart';
import 'package:fpaper/util/memory_store.dart';

class UserService {
  UserService({
    required UserRepository userRepository,
    required AuthRepository authRepository,
    required DeviceRepository deviceRepository,
    required DeviceInfoDatasource deviceInfoDatasource,
    required InMemoryStore<User?> userStore,
    required InMemoryStore<bool> shouldRegisterDeviceStore,
  })  : _userRepository = userRepository,
        _authRepository = authRepository,
        _deviceRepository = deviceRepository,
        _deviceInfoDatasource = deviceInfoDatasource,
        _userStore = userStore,
        _shouldRegisterDeviceStore = shouldRegisterDeviceStore {
    _authRepository.authUserStream.listen((authUser) async {
      if (authUser != null) {
        final user = await _fetchUser(authUser);
        final shouldRegisterDevice = await _getShouldRegisterDevice(user);

        _userStore.value = user;
        _shouldRegisterDeviceStore.value = shouldRegisterDevice;
      } else {
        _userStore.value = null;
      }
    });
  }

  final UserRepository _userRepository;
  final AuthRepository _authRepository;
  final DeviceRepository _deviceRepository;
  final DeviceInfoDatasource _deviceInfoDatasource;
  final InMemoryStore<User?> _userStore;
  final InMemoryStore<bool> _shouldRegisterDeviceStore;

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

  Future<User> _fetchUser(AuthUser authUser) async {
    final user = await _userRepository.getOrCreateUser(authUser);
    final userDevices = await _deviceRepository.getUserDevices(userId: user.id);
    final filledUser = user.copyWith(devices: userDevices);
    return filledUser;
  }

  Future<void> signOut() => _authRepository.signOut();

  // * it checks if the current device id ISN'T inside the user devices
  Future<bool> _getShouldRegisterDevice(User user) async {
    final deviceId = await _deviceInfoDatasource.getDeviceId();
    final isCurrentDeviceIdRegistered =
        user.devices.map((device) => device.id).contains(deviceId);

    // * if the current device id isn't registered, we must register it
    return !isCurrentDeviceIdRegistered;
  }

  bool get shouldRegisterDevice => _shouldRegisterDeviceStore.value;
  Stream<bool> get watchShouldRegisterDevice =>
      _shouldRegisterDeviceStore.watch;

  User? get currentUser => _userStore.value;
  Stream<User?> get watchUser => _userStore.watch;
}
