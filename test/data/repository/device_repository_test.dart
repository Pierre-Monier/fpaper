import 'package:core/model/device.dart';
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
      () => mockFirestoreDatasource.createOrUpdateDevice(
        id: mockDeviceId,
        data: mockDeviceCreationData,
      ),
    ).thenAnswer((_) => Future.value(mockDeviceData));

    final deviceRepository =
        DeviceRepository(firestoreDatasource: mockFirestoreDatasource);

    final device = await deviceRepository.createDevice(
      deviceId: mockDeviceId,
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

  test("it should be able to update a device", () async {
    // TODO: here update test
    when(
      () => mockFirestoreDatasource.createOrUpdateDevice(
        id: mockDeviceId,
        data: mockDeviceToUpdateData,
      ),
    ).thenAnswer((_) => Future.value(mockUpdatedDeviceData));

    final deviceRepository =
        DeviceRepository(firestoreDatasource: mockFirestoreDatasource);

    const updatedDevice = Device(
      id: mockDeviceId,
      userId: mockUserId,
      name: mockDeviceName,
      registrationToken: mockRegistrationToken,
      platform: FpaperPlatform.android,
    );

    final device = await deviceRepository.updateDeviceRegistrationToken(
      registrationToken: mockUpdatedRegistrationToken,
      device: updatedDevice,
    );

    expect(device.id, mockDeviceId);
    expect(device.userId, mockUserId);
    expect(device.name, mockDeviceName);
    expect(device.registrationToken, mockUpdatedRegistrationToken);
    expect(device.platform, FpaperPlatform.android);
  });
}
