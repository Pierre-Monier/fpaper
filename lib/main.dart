import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpaper/firebase_options.dart';
import 'package:fpaper/providers.dart';
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
  await dotenv.load();
  runApp(
    const ProviderScope(child: Fpaper()),
  );
}

class Fpaper extends ConsumerStatefulWidget {
  const Fpaper();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FpaperState();
}

class _FpaperState extends ConsumerState<Fpaper> {
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
    final appRouter = ref.watch(appRouterProvider);

    return MaterialApp.router(
      routerDelegate: appRouter.routerDelegate,
      routeInformationParser: appRouter.routeInformationParser,
      routeInformationProvider: appRouter.routeInformationProvider,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
