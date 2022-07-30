import 'package:core/model/device.dart';
import 'package:core/model/user.dart';

class Fpaper {
  const Fpaper({
    required this.wallpaperPath,
    required this.from,
    required this.destination,
    required this.date,
  });

  final String wallpaperPath;
  final User from;
  final List<Device> destination;
  final DateTime date;
}
