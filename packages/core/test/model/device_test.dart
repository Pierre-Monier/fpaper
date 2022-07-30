import 'package:core/model/device.dart';
import 'package:core/model/platform.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock/data.dart';

void main() {
  test("we can create Device object", () {
    const device = Device(
      name: mockDeviceName,
      platform: FpaperPlatform.android,
      registrationToken: mockRegistrationToken,
    );

    expect(device.name, mockDeviceName);
    expect(device.registrationToken, mockRegistrationToken);
    expect(device.platform, FpaperPlatform.android);
  });
}
