import 'package:auth/data/repository/auth_repository.dart';
import 'package:auth/data/source/firebase_auth_datasource.dart';
import 'package:core/model/user.dart';
import 'package:db/data/source/firestore_datasource.dart';
import 'package:device_info/data/source/device_info_datasource.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpaper/data/repository/device_repository.dart';
import 'package:fpaper/data/repository/friend_repository.dart';
import 'package:fpaper/data/repository/user_repository.dart';
import 'package:fpaper/presentation/auth/controller/auth_controller.dart';
import 'package:fpaper/presentation/auth/controller/auth_state.dart';
import 'package:fpaper/routing/router.dart';
import 'package:fpaper/service/user_service.dart';
import 'package:fpaper/util/memory_store.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notification/data/source/notification_datasource.dart';

final firebaseAuthDatasourceProvider = Provider<FirebaseAuthDataSource>((ref) {
  return FirebaseAuthDataSource(firebaseAuth: firebaseAuth);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final firebaseAuthDataSource = ref.read(firebaseAuthDatasourceProvider);

  return AuthRepository(firebaseAuthDatasource: firebaseAuthDataSource);
});

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  final userService = ref.read(userServiceProvider);

  return AuthController(
    userService: userService,
  );
});

final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn();
});

final githubSignInProvider = Provider<GitHubSignIn>((ref) {
  final clientId = dotenv.env['GITHUB_CLIENT_ID'] ?? '';
  final clientSecret = dotenv.env['GITHUB_CLIENT_SECRET'] ?? '';
  final redirectUrl = dotenv.env['GITHUB_REDIRECT_URL'] ?? '';

  return GitHubSignIn(
    clientId: clientId,
    clientSecret: clientSecret,
    redirectUrl: redirectUrl,
  );
});

final firestoreDatasourceProvider = Provider<FirestoreDatasource>((ref) {
  return FirestoreDatasource(firebaseFirestore: firebaseFirestore);
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final firestoreDatasource = ref.read(firestoreDatasourceProvider);

  return UserRepository(
    firestoreDatasource: firestoreDatasource,
  );
});

final deviceRepositoryProvider = Provider<DeviceRepository>((ref) {
  final firestoreDatasource = ref.read(firestoreDatasourceProvider);

  return DeviceRepository(firestoreDatasource: firestoreDatasource);
});

final deviceInfoDatasourceProvider = Provider<DeviceInfoDatasource>((ref) {
  return DeviceInfoDatasource(deviceInfoPlugin: deviceInfoPlugin);
});

final notificationDatasourceProvider = Provider<NotificationDatasource>((ref) {
  return NotificationDatasource(
    firebaseMessaging: firebaseMessaging,
  );
});

final friendRepositoryProvider = Provider<FriendRepository>((ref) {
  final firestoreDatasource = ref.read(firestoreDatasourceProvider);

  return FriendRepository(firestoreDatasource: firestoreDatasource);
});

final userServiceProvider = Provider<UserService>((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  final authRepository = ref.read(authRepositoryProvider);
  final deviceRepository = ref.read(deviceRepositoryProvider);
  final friendRepository = ref.read(friendRepositoryProvider);
  final deviceInfoDatasource = ref.read(deviceInfoDatasourceProvider);
  final notificationDatasource = ref.read(notificationDatasourceProvider);
  final userStore = InMemoryStore<User?>(null);

  return UserService(
    userRepository: userRepository,
    authRepository: authRepository,
    deviceRepository: deviceRepository,
    friendRepository: friendRepository,
    deviceInfoDatasource: deviceInfoDatasource,
    notificationDatasource: notificationDatasource,
    userStore: userStore,
  );
});

final appRouterProvider = Provider<GoRouter>((ref) {
  final userService = ref.read(userServiceProvider);

  return getAppRouter(userService);
});
