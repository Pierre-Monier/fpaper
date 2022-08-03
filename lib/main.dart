import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpaper/firebase_options.dart';
import 'package:fpaper/presentation/auth/ui/auth_page.dart';
import 'package:wallpaper/wallpaper.dart';

Future<void> _messageHandler(RemoteMessage message) {
  final url = message.data["url"] as String;
  return setAndroidWallpaper(url);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  runApp(
    const ProviderScope(child: Fpaper()),
  );
}

class Fpaper extends StatefulWidget {
  const Fpaper();

  @override
  State<StatefulWidget> createState() => _FpaperState();
}

class _FpaperState extends State<Fpaper> {
  late FirebaseMessaging messaging;
  @override
  void initState() {
    super.initState();
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      print(value);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final url = message.data["url"] as String;
      setAndroidWallpaper(url);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthPage(),
    );
  }
}
