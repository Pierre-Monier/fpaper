import 'package:core/model/platform.dart';

class Device {
  const Device({
    required this.name,
    required this.registrationToken,
    required this.platform,
  });

  final String name;
  final String registrationToken;
  final FpaperPlatform platform;
}
