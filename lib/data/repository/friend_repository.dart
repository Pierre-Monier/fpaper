import 'package:core/model/user.dart';
import 'package:db/data/source/firestore_datasource.dart';
import 'package:fpaper/data/dto/user_dto.dart';

class FriendRepository {
  const FriendRepository({
    required FirestoreDatasource firestoreDataSource,
  }) : _firestoreDatasource = firestoreDataSource;

  final FirestoreDatasource _firestoreDatasource;

  Future<List<User>> getFriends({required List<String> friendsId}) async {
    final friendsData =
        await _firestoreDatasource.getFriends(friendsId: friendsId);

    final friends = friendsData
        .map<User?>((deviceData) {
          try {
            return UserDto.fromMap(deviceData);
          } on TypeError {
            return null;
          }
        })
        .whereType<User>()
        .toList();

    return friends;
  }
}
