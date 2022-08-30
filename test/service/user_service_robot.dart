import 'package:core/model/user.dart';
import 'package:flutter/foundation.dart';
import 'package:mocktail/mocktail.dart';

import 'mock/data.dart';
import 'user_service_test.dart';

class UserServiceRobot {
  Future<void> loginWithGithub() async {
    when(
      () => mockAuthRepository.signUserWithGithub(
        token: mockGithubToken,
      ),
    ).thenAnswer((_) {
      mockAuthUserStream.add(mockAuthUser);
      return Future.value();
    });

    when(
      () => mockUserRepository.getOrCreateUser(mockAuthUser),
    ).thenAnswer((_) => Future.value(userFromGithub));

    await userService.loginWithGithub(
      token: mockGithubToken,
    );
  }

  Future<void> loginWithGoogle({bool withDevices = true}) async {
    when(
      () => mockAuthRepository.signUserWithGoogle(
        accessToken: mockGoogleAccessToken,
        idToken: mockGoogleIdToken,
      ),
    ).thenAnswer((_) {
      mockAuthUserStream.add(mockAuthUser);
      return Future.value();
    });

    when(
      () => mockUserRepository.getOrCreateUser(mockAuthUser),
    ).thenAnswer(
      (_) => Future.value(
        getUserFromGoogle(withDevices: withDevices),
      ),
    );
    when(
      () => mockDeviceRepository.getUserDevices(userId: mockAuthUserUid),
    ).thenAnswer(
      (_) => Future.value(withDevices ? mockUserDevices : []),
    );

    await userService.loginWithGoogle(
      accessToken: mockGoogleAccessToken,
      idToken: mockGoogleIdToken,
    );
  }

  bool compareUserWithWantedUser({
    required User user,
    required User wantedUser,
  }) {
    final hasCorrectUsername = user.username == wantedUser.username;
    final hasCorrectId = user.id == mockAuthUser.uid;
    final hasCorrectDevices = listEquals(user.devices, wantedUser.devices);
    final hasCorrectFriends = listEquals(user.friends, wantedUser.friends);
    final hasCorrectPushHistoryValues = listEquals(
      user.pushHistory.values.toList(),
      wantedUser.pushHistory.values.toList(),
    );
    final hasCorrectPullHistoryValues = listEquals(
      user.pullHistory.values.toList(),
      wantedUser.pullHistory.values.toList(),
    );
    final hasCorrectProfilPicturePath =
        user.profilPicturePath == wantedUser.profilPicturePath;

    return hasCorrectUsername &&
        hasCorrectId &&
        hasCorrectDevices &&
        hasCorrectFriends &&
        hasCorrectPushHistoryValues &&
        hasCorrectPullHistoryValues &&
        hasCorrectProfilPicturePath;
  }
}
