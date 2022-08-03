import 'package:flutter/material.dart';

@immutable
class AppIcons {
  static const fontFamily = 'Remix Icon';
  static const packageName = 'ui';

  const AppIcons._();

  static const githubIcon =
      IconData(0xEDCA, fontFamily: fontFamily, fontPackage: packageName);
  static const googleIcon =
      IconData(0xEDD4, fontFamily: fontFamily, fontPackage: packageName);
}
