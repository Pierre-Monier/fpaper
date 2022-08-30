import 'package:core/model/user.dart';
import 'package:db/data/source/firestore_datasource.dart';
import 'package:fpaper/data/dto/user_dto.dart';

class FriendRepository {
  const FriendRepository({
    required FirestoreDatasource firestoreDatasource,
  }) : _firestoreDatasource = firestoreDatasource;

  final FirestoreDatasource _firestoreDatasource;

  Future<List<User>> getFriends({required String userId}) async {
    final friendsData = await _firestoreDatasource.getFriends(userId: userId);

    final friends = friendsData
        .map<User?>((friendData) {
          try {
            return UserDto.fromMap(friendData);
          } on TypeError {
            return null;
          }
        })
        .whereType<User>()
        .toList();

    return friends;
  }
}
