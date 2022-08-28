import 'dart:io';

import 'package:device_info/data/source/null_android_id_exception.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class DeviceInfoDatasource {
  const DeviceInfoDatasource({required DeviceInfoPlugin deviceInfoPlugin})
      : _deviceInfoPlugin = deviceInfoPlugin;

  @visibleForTesting
  static const defaultDeviceName = "DefaultName";

  final DeviceInfoPlugin _deviceInfoPlugin;

  // ! we can't test that because we can't mock Platform.isAndroid
  Future<String> getDeviceId() {
    if (Platform.isAndroid) {
      return getAndroidDeviceId();
    }

    throw UnimplementedError();
  }

  // ! we can't test that because we can't mock Platform.isAndroid
  Future<String> getDeviceName() {
    if (Platform.isAndroid) {
      return getAndroidDeviceName();
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

  @visibleForTesting
  Future<String> getAndroidDeviceName() async {
    final AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
    final deviceBrand = androidInfo.brand;
    final deviceName = androidInfo.device;

    if (deviceBrand == null || deviceName == null) {
      return defaultDeviceName;
    }

    return "$deviceBrand-$deviceName";
  }
}

final deviceInfoPlugin = DeviceInfoPlugin();
