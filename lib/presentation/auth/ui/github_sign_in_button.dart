import 'package:flutter/material.dart';
import 'package:ui/theme/icons.dart';
import 'package:ui/widget/sign_in_button.dart';

class GithubSignInButton extends StatelessWidget {
  const GithubSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SignInButton(
      icon: const Icon(AppIcons.githubIcon),
      text: "github",
      onTap: () {},
      isLoading: false,
    );
  }
}
