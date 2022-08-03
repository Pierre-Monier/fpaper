import 'package:auth/data/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:fpaper/repository/user_repository.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';

class MockGithubSignIn extends Mock implements GitHubSignIn {}

class MockGithubSignInResult extends Mock implements GitHubSignInResult {}

class MockBuildContext extends Mock implements BuildContext {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUserRepository extends Mock implements UserRepository {}
