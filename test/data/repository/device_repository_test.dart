import 'package:core/model/platform.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpaper/data/repository/device_repository.dart';
import 'package:mocktail/mocktail.dart';

import 'mock/data.dart';

void main() {
  test("it should be able to get the user list of device", () async {
    when(
      () => mockFirestoreDatasource.getUserDevices(userId: mockUserId),
    ).thenAnswer((_) => Future.value(mockUserDevicesData));

    final deviceReposository =
        DeviceRepository(firestoreDatasource: mockFirestoreDatasource);

    final devices = await deviceReposository.getUserDevices(userId: mockUserId);

    expect(devices.isEmpty, false);

    final device = devices.first;

    expect(device.id, mockDeviceId);
    expect(device.userId, mockUserId);
    expect(device.name, mockDeviceName);
    expect(device.registrationToken, mockRegistrationToken);
    expect(device.platform, FpaperPlatform.android);
  });

  test("it should be able to create a device", () async {
    when(
      () => mockFirestoreDatasource.createDevice(
        data: mockDeviceCreationData,
      ),
    ).thenAnswer((_) => Future.value(mockDeviceData));

    final deviceRepository =
        DeviceRepository(firestoreDatasource: mockFirestoreDatasource);

    final device = await deviceRepository.createDevice(
      userId: mockUserId,
      deviceName: mockDeviceName,
      registrationToken: mockRegistrationToken,
    );

    expect(device.id, mockDeviceId);
    expect(device.userId, mockUserId);
    expect(device.name, mockDeviceName);
    expect(device.registrationToken, mockRegistrationToken);
    expect(device.platform, FpaperPlatform.android);
  });
}
