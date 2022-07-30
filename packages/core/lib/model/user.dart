import 'dart:collection';

import 'package:core/model/device.dart';
import 'package:core/model/fpaper.dart';
import 'package:core/util/date_time_reverse_compare_to.dart';

class User {
  User({
    required this.username,
    required this.devices,
    required this.friends,
    required List<Fpaper> pullHistoryData,
    required List<Fpaper> pushHistoryData,
    this.profilPicturePath,
  })  : pullHistory = _orderHistoryData(pullHistoryData),
        pushHistory = _orderHistoryData(pushHistoryData);

  /// used to order the fpapers data antichronologicaly
  static SplayTreeMap<DateTime, Fpaper> _orderHistoryData(
    List<Fpaper> fpapers,
  ) =>
      SplayTreeMap.from(
        {for (var element in fpapers) element.date: element},
        (key1, key2) => key1.reverseCompareTo(key2),
      );

  final String username;
  final List<Device> devices;
  final List<User> friends;

  /// the fpaper push history, naturally ordered in anti chronologic order
  final SplayTreeMap<DateTime, Fpaper> pushHistory;

  /// the fpaper pull history, naturally ordered in anti chronologic order
  final SplayTreeMap<DateTime, Fpaper> pullHistory;
  final String? profilPicturePath;
}