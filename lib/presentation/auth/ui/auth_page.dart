import 'package:flutter/material.dart';
import 'package:fpaper/presentation/auth/ui/github_sign_in_button.dart';
import 'package:fpaper/presentation/auth/ui/google_sign_in_button.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            GithubSignInButton(),
            GoogleSignInButton(),
          ],
        ),
      ),
    );
  }
}
