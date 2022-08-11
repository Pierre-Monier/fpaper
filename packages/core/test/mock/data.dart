import 'dart:collection';

import 'package:core/model/device.dart';
import 'package:core/model/fpaper.dart';
import 'package:core/model/platform.dart';
import 'package:core/model/user.dart';

const mockUserId = "mockUserId";
const mockDeviceId = "mockDeviceId";
const mockDeviceName = "deviceName";
const mockRegistrationToken = "registrationToken";
const mockWallpaperPath = "wallpaperPath";
const mockDevices = [
  Device(
    id: mockDeviceId,
    userId: mockUserId,
    name: mockDeviceName,
    registrationToken: mockRegistrationToken,
    platform: FpaperPlatform.android,
  )
];
final mockUser = User(
  id: "id",
  username: "userA",
  devices: mockDevices,
  friends: mockFriends,
  pullHistoryData: [],
  pushHistoryData: [],
);
final mockFpaperHistory = SplayTreeMap<DateTime, Fpaper>.from({});
const mockHistoryData = <Fpaper>[];
const mockFriends = <User>[];
