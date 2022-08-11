import 'dart:io';

import 'package:device_info/data/source/null_android_id_exception.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class DeviceDatasource {
  const DeviceDatasource({required DeviceInfoPlugin deviceInfoPlugin})
      : _deviceInfoPlugin = deviceInfoPlugin;

  final DeviceInfoPlugin _deviceInfoPlugin;

  // ! we can't test that because we can't mock Platform.isAndroid
  Future<String> getDeviceId() {
    if (Platform.isAndroid) {
      return getAndroidDeviceId();
    }

    throw UnimplementedError();
  }

  @visibleForTesting
  Future<String> getAndroidDeviceId() async {
    final AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
    final deviceId = androidInfo.id;

    if (deviceId == null) {
      throw NullAndroidIdException();
    }

    return deviceId;
  }
}
