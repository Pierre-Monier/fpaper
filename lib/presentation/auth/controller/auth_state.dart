import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthState {
  const AuthState({
    required this.githubSignIn,
    required this.googleSignIn,
  });

  factory AuthState.initial() => const AuthState(
        githubSignIn: AsyncValue.data(null),
        googleSignIn: AsyncValue.data(null),
      );

  final AsyncValue<void> githubSignIn;
  final AsyncValue<void> googleSignIn;

  AuthState copyWith({
    AsyncValue<void>? githubSignIn,
    AsyncValue<void>? googleSignIn,
  }) =>
      AuthState(
        githubSignIn: githubSignIn ?? this.githubSignIn,
        googleSignIn: googleSignIn ?? this.googleSignIn,
      );
}
