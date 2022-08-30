import 'package:auth/data/repository/auth_repository.dart';
import 'package:auth/model/auth_user.dart';
import 'package:collection/collection.dart';
import 'package:core/model/user.dart';
import 'package:device_info/data/source/device_info_datasource.dart';
import 'package:fpaper/data/repository/device_repository.dart';
import 'package:fpaper/data/repository/user_repository.dart';
import 'package:fpaper/util/memory_store.dart';
import 'package:notification/data/source/notification_datasource.dart';

class UserService {
  UserService({
    required UserRepository userRepository,
    required AuthRepository authRepository,
    required DeviceRepository deviceRepository,
    required DeviceInfoDatasource deviceInfoDatasource,
    required NotificationDatasource notificationDatasource,
    required InMemoryStore<User?> userStore,
  })  : _userRepository = userRepository,
        _authRepository = authRepository,
        _deviceRepository = deviceRepository,
        _deviceInfoDatasource = deviceInfoDatasource,
        _notificationDatasource = notificationDatasource,
        _userStore = userStore {
    _authRepository.authUserStream.listen((authUser) async {
      if (authUser != null) {
        final user = await _fetchUser(authUser);
        final withUpToDateDeviceUser = await _processUserDevice(user: user);
        _userStore.value = withUpToDateDeviceUser;
      } else {
        _userStore.value = null;
      }
    });
  }

  final UserRepository _userRepository;
  final AuthRepository _authRepository;
  final DeviceRepository _deviceRepository;
  final DeviceInfoDatasource _deviceInfoDatasource;
  final NotificationDatasource _notificationDatasource;
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

  Future<User> _fetchUser(AuthUser authUser) async {
    final user = await _userRepository.getOrCreateUser(authUser);
    final userDevices = await _deviceRepository.getUserDevices(userId: user.id);
    final filledUser = user.copyWith(devices: userDevices);
    return filledUser;
  }

  Future<void> signOut() => _authRepository.signOut();

  /// returns a user with the latest device information.
  Future<User> _processUserDevice({required User user}) async {
    User? updatedUser;
    final shouldRegisterDevice = await _getShouldRegisterDevice(user: user);
    final shouldUpdateRegistrationToken =
        await _getShouldUpdateRegistrationToken(user: user);

    if (shouldRegisterDevice) {
      updatedUser = await _registerUserDevice(user: user);
    } else if (shouldUpdateRegistrationToken) {
      updatedUser = await _updateRegistrationToken(user: user);
    }

    // * we return the updated user if we have updated it
    return updatedUser ?? user;
  }

  /// it return the user if we can register the device
  Future<User?> _registerUserDevice({required User user}) async {
    User? updatedUser;
    final deviceName = await _deviceInfoDatasource.getDeviceName();
    final registrationToken =
        await _notificationDatasource.getRegistrationToken();

    if (registrationToken != null) {
      final userId = user.id;
      final deviceId = await _deviceInfoDatasource.getDeviceId();
      final device = await _deviceRepository.createDevice(
        deviceId: deviceId,
        userId: userId,
        deviceName: deviceName,
        registrationToken: registrationToken,
      );

      final userWithRegisteredDevice =
          user.copyWith(devices: [...user.devices, device]);
      updatedUser = userWithRegisteredDevice;
    }

    return updatedUser;
  }

  /// it return the user if we can update the registration token
  Future<User?> _updateRegistrationToken({required User user}) async {
    User? updatedUser;
    final deviceId = await _deviceInfoDatasource.getDeviceId();
    final device = user.devices.firstWhereOrNull(
      (device) => device.id == deviceId,
    );

    final registrationToken =
        await _notificationDatasource.getRegistrationToken();

    if (device != null && registrationToken != null) {
      final updatedDevice =
          await _deviceRepository.updateDeviceRegistrationToken(
        registrationToken: registrationToken,
        device: device,
      );

      final cleanedDevices =
          user.devices.where((device) => device.id != deviceId);

      final userWithUpdatedDevices = user.copyWith(
        devices: [...cleanedDevices, updatedDevice],
      );
      updatedUser = userWithUpdatedDevices;
    }

    return updatedUser;
  }

  // * it checks if the current device id ISN'T inside the user devices
  Future<bool> _getShouldRegisterDevice({
    required User user,
  }) async {
    final deviceId = await _deviceInfoDatasource.getDeviceId();
    final isCurrentDeviceIdRegistered =
        user.devices.map((device) => device.id).contains(deviceId);

    // * if the current device id isn't registered, we must register it
    return !isCurrentDeviceIdRegistered;
  }

  Future<bool> _getShouldUpdateRegistrationToken({
    required User user,
  }) async {
    final deviceId = await _deviceInfoDatasource.getDeviceId();
    final device =
        user.devices.firstWhereOrNull((device) => device.id == deviceId);
    final registrationToken =
        await _notificationDatasource.getRegistrationToken();

    return device != null && device.registrationToken != registrationToken;
  }

  User? get currentUser => _userStore.value;
  Stream<User?> get watchUser => _userStore.watch;
}
