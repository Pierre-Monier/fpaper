library wallpaper;

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

// ! this method is a temporary POC that change user wallpaper
Future<void> setAndroidWallpaper(String url) async {
  var file = await DefaultCacheManager().getSingleFile(url);

  await WallpaperManagerFlutter()
      .setwallpaperfromFile(file, WallpaperManagerFlutter.BOTH_SCREENS);
}
