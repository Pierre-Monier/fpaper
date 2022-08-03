import 'package:core/model/fpaper.dart';
import 'package:core/model/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock/data.dart';

const username = "username";
const id = "id";

void main() {
  test('we can create User object with profilePicturePath', () {
    const profilePicturePath = "profilePicturePath";

    final userWithProfilePicture = User(
      id: id,
      username: username,
      profilPicturePath: profilePicturePath,
      devices: mockDevices,
      friends: mockFriends,
      pushHistoryData: mockHistoryData,
      pullHistoryData: mockHistoryData,
    );

    expect(userWithProfilePicture.id, id);
    expect(userWithProfilePicture.username, username);
    expect(userWithProfilePicture.profilPicturePath, profilePicturePath);
    expect(userWithProfilePicture.devices, mockDevices);
    expect(userWithProfilePicture.friends, mockFriends);
    expect(userWithProfilePicture.pullHistory.values, mockHistoryData);
    expect(userWithProfilePicture.pushHistory.values, mockHistoryData);
  });

  test('we can create User object without profilePicturePath', () {
    final userWithoutProfilePicture = User(
      id: id,
      username: username,
      devices: mockDevices,
      friends: mockFriends,
      pushHistoryData: [],
      pullHistoryData: [],
    );

    expect(userWithoutProfilePicture.id, id);
    expect(userWithoutProfilePicture.username, username);
    expect(userWithoutProfilePicture.profilPicturePath, null);
    expect(userWithoutProfilePicture.devices, mockDevices);
    expect(userWithoutProfilePicture.friends, mockFriends);
    expect(userWithoutProfilePicture.pullHistory.values, mockHistoryData);
    expect(userWithoutProfilePicture.pushHistory.values, mockHistoryData);
  });

  test('User pull/push history are ordered in antichronologic order', () {
    final juneDateTime = DateTime.utc(2022, 6);
    final julyDateTime = DateTime.utc(2022, 7);

    final chronologicallyOrderedFpaper = [
      Fpaper(
        wallpaperPath: mockWallpaperPath,
        from: mockUser,
        destination: mockDevices,
        date: juneDateTime,
      ),
      Fpaper(
        wallpaperPath: mockWallpaperPath,
        from: mockUser,
        destination: mockDevices,
        date: julyDateTime,
      )
    ];

    final user = User(
      id: id,
      username: username,
      devices: mockDevices,
      friends: mockFriends,
      pushHistoryData: chronologicallyOrderedFpaper,
      pullHistoryData: chronologicallyOrderedFpaper,
    );

    final pullHistoryDate = user.pullHistory.keys.toList();
    final pushHistoryDate = user.pushHistory.keys.toList();

    expect(pullHistoryDate[0].isAfter(pullHistoryDate[1]), true);
    expect(pushHistoryDate[0].isAfter(pushHistoryDate[1]), true);
  });
}
