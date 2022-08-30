import 'package:flutter_test/flutter_test.dart';
import 'package:fpaper/data/repository/friend_repository.dart';
import 'package:mocktail/mocktail.dart';

import 'mock/data.dart';

void main() {
  test('it should be able to get all friends', () async {
    const friendsId = [mockUserId];
    when(() => mockFirestoreDatasource.getFriends(friendsId: friendsId))
        .thenAnswer(
      (_) => Future.value([friendFromDbData]),
    );

    final friendRepository =
        FriendRepository(firestoreDataSource: mockFirestoreDatasource);

    final friends = await friendRepository.getFriends(friendsId: friendsId);

    expect(friends.first.id, mockUserId);
    expect(friends.first.username, userFromDbUsername);
    expect(friends.first.profilPicturePath, userFromDbProfilPicturePath);
  });
}
