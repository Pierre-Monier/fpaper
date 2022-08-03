import 'package:auth/model/auth_user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock/data.dart';

void main() {
  test('it should be possible to create AuthUser', () {
    const authUser = AuthUser(
      uid: mockUID,
      username: mockUsername,
      profilePicturesPath: mockProfilePicturesPath,
    );

    expect(authUser.uid, mockUID);
    expect(authUser.username, mockUsername);
    expect(authUser.profilePicturesPath, mockProfilePicturesPath);
  });
}
