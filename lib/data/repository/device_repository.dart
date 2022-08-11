import 'package:core/model/device.dart';
import 'package:core/model/platform.dart';
import 'package:db/data/source/firestore_datasource.dart';

class DeviceRepository {
  const DeviceRepository({
    required FirestoreDatasource firestoreDatasource,
  }) : _firestoreDatasource = firestoreDatasource;

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

  Device _deviceFromMap(Map<String, dynamic> data) => Device(
        id: data["id"] as String,
        userId: data["userId"] as String,
        name: data["name"] as String,
        registrationToken: data["registrationToken"] as String,
        platform: _getPlatform(data["platform"] as String),
      );

  FpaperPlatform _getPlatform(String value) {
    if (value == FpaperPlatform.android.name) {
      return FpaperPlatform.android;
    }

    throw UnimplementedError();
  }
}
