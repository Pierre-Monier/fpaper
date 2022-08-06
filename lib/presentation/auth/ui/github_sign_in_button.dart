import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpaper/providers.dart';
import 'package:ui/theme/icons.dart';
import 'package:ui/widget/sign_in_button.dart';

class GithubSignInButton extends ConsumerWidget {
  const GithubSignInButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.read(authControllerProvider.notifier);
    final githubSignIn = ref.read(githubSignInProvider);
    final authState = ref.watch(authControllerProvider);

    return SignInButton(
      icon: const Icon(AppIcons.githubIcon),
      text: "github",
      onTap: () {
        authController.signInWithGithub(
          context: context,
          githubSignIn: githubSignIn,
        );
      },
      isLoading: authState.githubSignIn.isLoading,
    );
  }
}
