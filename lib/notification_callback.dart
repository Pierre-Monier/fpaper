import 'package:notification/data/source/notification_datasource.dart';
import 'package:wallpaper/wallpaper.dart';

Future<void> androidNotificationCallback(AndroidNotificationMessage message) {
  final url = message.data["url"] as String;
  return setWallpaper(url);
}
