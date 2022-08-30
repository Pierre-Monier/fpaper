import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationDatasource {
  const NotificationDatasource({
    required FirebaseMessaging firebaseMessaging,
  }) : _firebaseMessaging = firebaseMessaging;

  final FirebaseMessaging _firebaseMessaging;

  void onBackgroundMessage({
    required AndroidNotificationCallback androidCallback,
  }) {
    if (Platform.isAndroid) {
      FirebaseMessaging.onBackgroundMessage(androidCallback);
    } else {
      throw UnimplementedError();
    }
  }

  StreamSubscription onNotification({
    required AndroidNotificationCallback androidCallback,
  }) {
    if (Platform.isAndroid) {
      return FirebaseMessaging.onMessage.listen(androidCallback);
    }

    throw UnimplementedError();
  }

  Future<String?> getRegistrationToken() {
    if (Platform.isAndroid) {
      return _firebaseMessaging.getToken();
    } else {
      throw UnimplementedError();
    }
  }
}

final firebaseMessaging = FirebaseMessaging.instance;

typedef AndroidNotificationMessage = RemoteMessage;

typedef AndroidNotificationCallback = Future<void> Function(
    AndroidNotificationMessage);
