import 'package:auth/model/auth_user.dart';

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
