library wallpaper;

import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

Future<void> setWallpaper(String url) async {
  if (Platform.isAndroid) {
    return _setAndroidWallpaper(url);
  }

  throw UnimplementedError();
}

Future<void> _setAndroidWallpaper(String url) async {
  final file = await DefaultCacheManager().getSingleFile(url);

  await WallpaperManagerFlutter()
      .setwallpaperfromFile(file, WallpaperManagerFlutter.BOTH_SCREENS);
}
