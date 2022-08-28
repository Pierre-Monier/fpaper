import 'package:auth/model/auth_user.dart';
import 'package:core/model/device.dart';
import 'package:core/model/platform.dart';
import 'package:core/model/user.dart';

import '../../data/repository/mock/data.dart';
import 'class.dart';

final mockUserRepository = MockUserRepository();
final mockAuthRepository = MockAuthRepository();
final mockDeviceRepository = MockDeviceRepository();
final mockDeviceInfoDatasource = MockDeviceInfoDatasource();
const mockGoogleAccessToken = "mockGoogleAccessToken";
const mockGoogleIdToken = "mockGoogleIdToken";
const mockGithubToken = "mockGithubToken";
const mockAuthUserUid = "mockAuthUserUid";
const mockAuthUser = AuthUser(
  uid: mockAuthUserUid,
  username: "username",
  profilePicturesPath: "profilePicturesPath",
);
const userFromGoogleUsername = "userFromGoogleUsername";

final userFromGoogle = User(
  id: mockAuthUserUid,
  username: userFromGoogleUsername,
  devices: mockUserDevices,
  friends: [],
  pullHistoryData: [],
  pushHistoryData: [],
);

const userFromGithubUsername = "userFromGithubUsername";

final userFromGithub = User(
  id: mockAuthUserUid,
  username: userFromGoogleUsername,
  devices: mockUserDevices,
  friends: [],
  pullHistoryData: [],
  pushHistoryData: [],
);

const mockDeviceId = "mockDeviceId";
const mockDeviceName = "mockDeviceName";
const mockRegistrationToken = "mockRegistrationToken";
const mockDevicePlatform = FpaperPlatform.android;
const mockDevice = Device(
  id: mockDeviceId,
  userId: mockUserId,
  name: mockDeviceName,
  registrationToken: mockRegistrationToken,
  platform: mockDevicePlatform,
);
const mockUserDevices = [mockDevice];
