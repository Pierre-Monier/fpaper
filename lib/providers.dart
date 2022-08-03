import 'package:auth/data/repository/auth_repository.dart';
import 'package:auth/data/source/firebase_auth_datasource.dart';
import 'package:db/data/source/firestore_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpaper/presentation/auth/controller/auth_controller.dart';
import 'package:fpaper/presentation/auth/controller/auth_state.dart';
import 'package:fpaper/repository/user_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

final firebaseAuthDatasourceProvider = Provider<FirebaseAuthDataSource>((ref) {
  return FirebaseAuthDataSource(firebaseAuth: firebaseAuth);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final firebaseAuthDataSource = ref.read(firebaseAuthDatasourceProvider);
  return AuthRepository(firebaseAuthDatasource: firebaseAuthDataSource);
});

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  final userRepository = ref.read(userRepositoryProvider);
  return AuthController(
    authRepository: authRepository,
    userRepository: userRepository,
  );
});

final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn();
});

final firestoreDatasourceProvider = Provider<FirestoreDatasource>((ref) {
  return FirestoreDatasource(firebaseFirestore: firebaseFirestore);
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final firestoreDatasource = ref.read(firestoreDatasourceProvider);
  return UserRepository(firestoreDatasource: firestoreDatasource);
});
