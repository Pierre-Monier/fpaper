import 'package:auth/model/auth_user.dart';

import './class.dart';

final mockGithubSignIn = MockGithubSignIn();
final mockGithubSignInResult = MockGithubSignInResult();
final mockBuildContext = MockBuildContext();
final mockGoogleSignIn = MockGoogleSignIn();
final mockAuthRepository = MockAuthRepository();
final mockUserRepository = MockUserRepository();
const mockGithubToken = 'fakegithubtoken';
const mockAuthUser = AuthUser(
  uid: "uid",
  username: "username",
  profilePicturesPath: "profilePicturesPath",
);
