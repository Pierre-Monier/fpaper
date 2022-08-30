import 'package:core/model/user.dart';

class UserDto extends User {
  static const _defaultUsername = "Unknown";

  UserDto({
    required super.id,
    required super.username,
    required super.devices,
    required super.friends,
    required super.pullHistoryData,
    required super.pushHistoryData,
    required super.profilPicturePath,
  });

  factory UserDto.fromMap(Map<String, dynamic> map) {
    return UserDto(
      id: map["id"] as String,
      username: map["username"] as String? ?? _defaultUsername,
      devices: [],
      friends: [],
      pullHistoryData: [],
      pushHistoryData: [],
      profilPicturePath: map["profilPicturePath"] as String?,
    );
  }
}
