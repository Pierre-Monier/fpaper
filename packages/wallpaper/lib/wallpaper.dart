library wallpaper;

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

// ! this method is a temporary POC that change user wallpaper
Future<void> tmp() async {
  String url =
      "https://images.pexels.com/photos/2246476/pexels-photo-2246476.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";

  var file = await DefaultCacheManager().getSingleFile(url);

  await WallpaperManagerFlutter()
      .setwallpaperfromFile(file, WallpaperManagerFlutter.HOME_SCREEN);
}
