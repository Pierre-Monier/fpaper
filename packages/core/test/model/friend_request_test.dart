import 'package:core/model/friend_request.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock/data.dart';

void main() {
  test("we can create FriendRequest object", () {
    const friendRequest = FriendRequest(
      from: mockFriendRequestFrom,
      to: mockFriendRequestTo,
      status: mockFriendRequestStatus,
    );

    expect(friendRequest.from, mockFriendRequestFrom);
    expect(friendRequest.to, mockFriendRequestTo);
    expect(friendRequest.status, mockFriendRequestStatus);
  });
}
