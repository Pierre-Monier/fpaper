import 'package:auth/model/auth_user.dart';
import 'package:core/model/platform.dart';

import 'class.dart';

final mockFirestoreDatasource = MockFirestoreDatasource();
const mockUid = "uid";
const mockUsername = "username";
const mockProfilePicturesPath = "profilePicturesPath";
const mockAuthUser = AuthUser(
  uid: mockUid,
  username: mockUsername,
  profilePicturesPath: mockProfilePicturesPath,
);
const userFromDbUsername = "userFromDbUsername";
const userFromDbProfilPicturePath = "userFromDbProfilPicturePath";
const friendFromDbData = {
  "id": mockUserId,
  "username": userFromDbUsername,
  "profilPicturePath": userFromDbProfilPicturePath,
};
const userFromDbData = {
  "username": userFromDbUsername,
  "profilPicturePath": userFromDbProfilPicturePath,
};
const userCreatedUsername = "userCreatedUsername";
const userCreatedProfilPicturePath = "userCreatedProfilPicturePath";
const userCreatedData = {
  "username": userCreatedUsername,
  "profilPicturePath": userCreatedProfilPicturePath,
};
const fullUserFromDbData = {
  "id": mockUserId,
  "username": userFromDbUsername,
  "profilPicturePath": userFromDbProfilPicturePath,
};
const mockDeviceId = "mockDeviceId";
const mockUserId = "mockUserId";
const mockDeviceName = "mockDeviceName";
const mockRegistrationToken = "mockRegistrationToken";
const mockUpdatedRegistrationToken = "mockUpdatedRegistrationToken";
final mockPlatform = FpaperPlatform.android.name;

final mockDeviceData = {
  "id": mockDeviceId,
  "userId": mockUserId,
  "name": mockDeviceName,
  "registrationToken": mockRegistrationToken,
  "platform": mockPlatform
};

final mockUpdatedDeviceData = {
  "id": mockDeviceId,
  "userId": mockUserId,
  "name": mockDeviceName,
  "registrationToken": mockUpdatedRegistrationToken,
  "platform": mockPlatform
};

final mockDeviceCreationData = {
  "userId": mockUserId,
  "name": mockDeviceName,
  "registrationToken": mockRegistrationToken,
  "platform": FpaperPlatform.android.name
};

final mockDeviceToUpdateData = {
  "userId": mockUserId,
  "name": mockDeviceName,
  "registrationToken": mockUpdatedRegistrationToken,
  "platform": FpaperPlatform.android.name
};

final mockUserDevicesData = [mockDeviceData];
