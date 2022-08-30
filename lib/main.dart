import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpaper/firebase_options.dart';
import 'package:fpaper/notification_callback.dart';
import 'package:fpaper/providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load();

  final container = ProviderContainer();

  final notificationDatasource = container.read(notificationDatasourceProvider);
  notificationDatasource.onBackgroundMessage(
    androidCallback: androidNotificationCallback,
  );

  runApp(
    UncontrolledProviderScope(container: container, child: const Fpaper()),
  );
}

class Fpaper extends ConsumerStatefulWidget {
  const Fpaper();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FpaperState();
}

class _FpaperState extends ConsumerState<Fpaper> {
  late StreamSubscription notificationSubscription;

  @override
  void initState() {
    super.initState();

    notificationSubscription =
        ref.read(notificationDatasourceProvider).onNotification(
              androidCallback: androidNotificationCallback,
            );
  }

  @override
  void dispose() {
    notificationSubscription.cancel();
    super.dispose();
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
