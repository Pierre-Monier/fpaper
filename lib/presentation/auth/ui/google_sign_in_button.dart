import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpaper/providers.dart';
import 'package:ui/theme/icons.dart';
import 'package:ui/widget/sign_in_button.dart';

class GoogleSignInButton extends ConsumerWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.read(authControllerProvider.notifier);
    final googleSignIn = ref.read(googleSignInProvider);
    final authState = ref.watch(authControllerProvider);

    return SignInButton(
      icon: const Icon(AppIcons.googleIcon),
      text: "google",
      onTap: () {
        authController.signInWithGoogle(googleSignIn: googleSignIn);
      },
      isLoading: authState.googleSignIn.isLoading,
    );
  }
}
