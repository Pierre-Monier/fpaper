import 'package:core/model/device.dart';
import 'package:core/model/platform.dart';
import 'package:db/data/source/firestore_datasource.dart';

class DeviceRepository {
  const DeviceRepository({
    required FirestoreDatasource firestoreDatasource,
  }) : _firestoreDatasource = firestoreDatasource;

  static const _userIdKey = "userId";
  static const _deviceNameKey = "name";
  static const _registrationTokenKey = "registrationToken";
  static const _platformKey = "platform";

  final FirestoreDatasource _firestoreDatasource;

  Future<List<Device>> getUserDevices({required String userId}) async {
    final devicesData =
        await _firestoreDatasource.getUserDevices(userId: userId);

    return devicesData
        .map<Device?>((deviceData) {
          try {
            return _deviceFromMap(deviceData);
          } on TypeError {
            return null;
          }
        })
        .whereType<Device>()
        .toList();
  }

  Future<Device> createDevice({
    required String deviceId,
    required String userId,
    required String deviceName,
    required String registrationToken,
  }) async {
    final deviceData = await _firestoreDatasource.createOrUpdateDevice(
      id: deviceId,
      data: {
        _userIdKey: userId,
        _deviceNameKey: deviceName,
        _registrationTokenKey: registrationToken,
        _platformKey: FpaperPlatform.android.name
      },
    );

    final device = _deviceFromMap(deviceData);
    return device;
  }

  Future<Device> updateDeviceRegistrationToken({
    required String registrationToken,
    required Device device,
  }) async {
    final updatedDeviceData = await _firestoreDatasource.createOrUpdateDevice(
      id: device.id,
      data: {
        _userIdKey: device.userId,
        _deviceNameKey: device.name,
        _registrationTokenKey: registrationToken,
        _platformKey: device.platform.name,
      },
    );

    final updatedDevice = _deviceFromMap(updatedDeviceData);
    return updatedDevice;
  }

  Device _deviceFromMap(Map<String, dynamic> data) => Device(
        id: data["id"] as String,
        userId: data[_userIdKey] as String,
        name: data[_deviceNameKey] as String,
        registrationToken: data[_registrationTokenKey] as String,
        platform: _getPlatform(data[_platformKey] as String),
      );

  FpaperPlatform _getPlatform(String value) {
    if (value == FpaperPlatform.android.name) {
      return FpaperPlatform.android;
    }

    throw UnimplementedError();
  }
}
