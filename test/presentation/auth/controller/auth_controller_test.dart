import 'package:auth/data/repository/auth_failed_exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpaper/presentation/auth/controller/auth_controller.dart';
import 'package:fpaper/presentation/auth/controller/auth_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock/data.dart';

const loadingState = AsyncLoading<void>();
const dataState = AsyncData<void>(null);
final errorPredicate = predicate<AsyncValue<void>>((value) {
  expect(value.hasError, true);
  expect(value, isA<AsyncError>());
  return true;
});

void main() {
  late AuthController signInController;

  setUpAll(() {
    when(() => mockGithubSignIn.signIn(mockBuildContext))
        .thenAnswer((_) => Future.value(mockGithubSignInResult));
    when(() => mockGithubSignInResult.token).thenReturn(mockGithubToken);
    when(mockGoogleSignIn.signIn).thenAnswer((_) => Future.value());
  });

  setUp(() {
    signInController = AuthController(
      userService: mockUserService,
    );
  });

  test('it should have an defined initial state', () async {
    expect(signInController.debugState, AuthState.initial());
  });

  test(
    'it should emit a AsyncLoading githubSignIn state then a AsyncData'
    ' githubSignIn state when signInWithGithub',
    () async {
      when(() => mockUserService.loginWithGithub(token: mockGithubToken))
          .thenAnswer(
        (_) => Future.value(),
      );

      expectLater(
        signInController.stream.map<AsyncValue>((event) => event.githubSignIn),
        emitsInOrder([
          loadingState,
          dataState,
        ]),
      );

      await signInController.signInWithGithub(
        context: mockBuildContext,
        githubSignIn: mockGithubSignIn,
      );
    },
  );

  test(
    'it should emit a AsyncLoading githubSignIn state then an AsyncError'
    ' githubSignIn state when signInWithGithub failed',
    () async {
      when(() => mockUserService.loginWithGithub(token: mockGithubToken))
          .thenAnswer(
        (_) => Future.delayed(throw AuthFailedException),
      );

      expectLater(
        signInController.stream.map<AsyncValue>((event) => event.githubSignIn),
        emitsInOrder([loadingState, errorPredicate]),
      );

      await signInController.signInWithGithub(
        context: mockBuildContext,
        githubSignIn: mockGithubSignIn,
      );
    },
  );

  test(
      'it should emit a AsyncLoading googleSignIn state then a AsyncData'
      ' googleSignIn state when signInWithGoogle', () async {
    when(
      () => mockUserService.loginWithGoogle(
        accessToken: null,
        idToken: null,
      ),
    ).thenAnswer(
      (_) => Future.value(),
    );

    expectLater(
      signInController.stream.map<AsyncValue>((event) => event.googleSignIn),
      emitsInOrder([
        loadingState,
        dataState,
      ]),
    );

    await signInController.signInWithGoogle(
      googleSignIn: mockGoogleSignIn,
    );
  });

  test(
      'it should emit a AsyncLoading googleSignIn state then an AsyncError'
      ' googleSignIn state when signInWIthGoogle failed', () async {
    when(
      () => mockUserService.loginWithGoogle(
        accessToken: null,
        idToken: null,
      ),
    ).thenAnswer(
      (_) => Future.delayed(throw AuthFailedException),
    );

    expectLater(
      signInController.stream.map<AsyncValue>((event) => event.googleSignIn),
      emitsInOrder([loadingState, errorPredicate]),
    );

    await signInController.signInWithGoogle(
      googleSignIn: mockGoogleSignIn,
    );
  });
}
