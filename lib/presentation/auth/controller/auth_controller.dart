import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpaper/presentation/auth/controller/auth_state.dart';
import 'package:fpaper/service/user_service.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends StateNotifier<AuthState> {
  AuthController({
    required UserService userService,
  })  : _userService = userService,
        super(AuthState.initial());

  final UserService _userService;

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> signInWithGithub({
    required BuildContext context,
    required GitHubSignIn githubSignIn,
  }) async {
    state = state.copyWith(githubSignIn: const AsyncValue.loading());

    final result = await githubSignIn.signIn(context);

    final newState = await AsyncValue.guard(
      () => _userService.loginWithGithub(token: result.token),
    );
    state = state.copyWith(githubSignIn: newState);
  }

  Future<void> signInWithGoogle({
    required GoogleSignIn googleSignIn,
  }) async {
    state = state.copyWith(googleSignIn: const AsyncValue.loading());
    // * Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final newState = await AsyncValue.guard(
      () => _userService.loginWithGoogle(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      ),
    );
    state = state.copyWith(googleSignIn: newState);
  }
}
