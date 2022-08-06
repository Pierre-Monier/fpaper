import 'package:auth/model/auth_user.dart';
import 'package:core/model/user.dart';

import 'class.dart';

final mockUserRepository = MockUserRepository();
final mockAuthRepository = MockAuthRepository();
const mockGoogleAccessToken = "mockGoogleAccessToken";
const mockGoogleIdToken = "mockGoogleIdToken";
const authUserFromGoogle = AuthUser(
  uid: "uid",
  username: "username",
  profilePicturesPath: "profilePicturesPath",
);
const userFromGoogleId = "userFromGoogleId";
const userFromGoogleUsername = "userFromGoogleUsername";

final userFromGoogle = User(
  id: userFromGoogleId,
  username: userFromGoogleUsername,
  devices: [],
  friends: [],
  pullHistoryData: [],
  pushHistoryData: [],
);
