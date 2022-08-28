import 'package:device_info/data/source/device_info_datasource.dart';
import 'package:device_info/data/source/null_android_id_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock/data.dart';

void main() {
  late final DeviceInfoDatasource deviceInfoDatasource;
  setUpAll(() {
    deviceInfoDatasource =
        DeviceInfoDatasource(deviceInfoPlugin: mockDeviceInfoPlugin);

    when(
      () => mockDeviceInfoPlugin.androidInfo,
    ).thenAnswer((_) => Future.value(mockAndroidDeviceInfo));
  });

  test(
    "it should be able to get android device id",
    () async {
      when(
        () => mockAndroidDeviceInfo.id,
      ).thenReturn(mockAndroidDeviceId);

      final deviceId = await deviceInfoDatasource.getAndroidDeviceId();

      expect(deviceId, mockAndroidDeviceId);
    },
  );

  test(
    "it should throw an exception if android id is null",
    () async {
      when(
        () => mockAndroidDeviceInfo.id,
      ).thenReturn(null);

      expect(
        () async => deviceInfoDatasource.getAndroidDeviceId(),
        throwsA(isA<NullAndroidIdException>()),
      );
    },
  );

  test(
    "it should get android device name",
    () async {
      const mockBrandName = "mockBrandName";
      const mockDeviceName = "mockDeviceName";

      when(
        () => mockAndroidDeviceInfo.brand,
      ).thenReturn(mockBrandName);
      when(
        () => mockAndroidDeviceInfo.device,
      ).thenReturn(mockDeviceName);

      final deviceName = await deviceInfoDatasource.getAndroidDeviceName();

      expect(
        deviceName,
        "$mockBrandName-$mockDeviceName",
      );
    },
  );

  test(
    "it should return a default when android device name can't be fetch",
    () async {
      when(
        () => mockAndroidDeviceInfo.brand,
      ).thenReturn(null);
      when(
        () => mockAndroidDeviceInfo.device,
      ).thenReturn(null);

      final deviceName = await deviceInfoDatasource.getAndroidDeviceName();

      expect(
        deviceName,
        DeviceInfoDatasource.defaultDeviceName,
      );
    },
  );
}
