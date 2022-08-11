import 'package:core/model/platform.dart';

class Device {
  const Device({
    required this.id,
    required this.userId,
    required this.name,
    required this.registrationToken,
    required this.platform,
  });

  final String id;
  final String userId;
  final String name;
  final String registrationToken;
  final FpaperPlatform platform;
}
