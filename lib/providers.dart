import 'package:auth/data/repository/auth_repository.dart';
import 'package:auth/data/source/firebase_auth_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpaper/presentation/auth/controller/auth_controller.dart';
import 'package:fpaper/presentation/auth/controller/auth_state.dart';
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
  return AuthController(authRepository: authRepository);
});

final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn();
});
