import 'package:device_info/data/source/device_datasource.dart';
import 'package:device_info/data/source/null_android_id_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock/data.dart';

void main() {
  late final DeviceDatasource deviceDatasource;
  setUpAll(() {
    deviceDatasource = DeviceDatasource(deviceInfoPlugin: mockDeviceInfoPlugin);

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

      final deviceId = await deviceDatasource.getAndroidDeviceId();

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
        () async => deviceDatasource.getAndroidDeviceId(),
        throwsA(isA<NullAndroidIdException>()),
      );
    },
  );
}
