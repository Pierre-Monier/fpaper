import 'package:auth/model/auth_user.dart';
import 'package:core/model/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpaper/service/user_service.dart';
import 'package:fpaper/util/memory_store.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/subjects.dart';

import 'mock/data.dart';

void main() {
  late UserService userService;
  late BehaviorSubject<AuthUser?> mockAuthUserStream;

  Future<void> _loginWithGoogle() async {
    when(
      () => mockAuthRepository.signUserWithGoogle(
        accessToken: mockGoogleAccessToken,
        idToken: mockGoogleIdToken,
      ),
    ).thenAnswer((_) {
      mockAuthUserStream.add(mockAuthUser);
      return Future.value();
    });

    when(
      () => mockUserRepository.getOrCreateUser(mockAuthUser),
    ).thenAnswer((_) => Future.value(userFromGoogle));

    await userService.loginWithGoogle(
      accessToken: mockGoogleAccessToken,
      idToken: mockGoogleIdToken,
    );
  }

  Future<void> _loginWithGithub() async {
    when(
      () => mockAuthRepository.signUserWithGithub(
        token: mockGithubToken,
      ),
    ).thenAnswer((_) {
      mockAuthUserStream.add(mockAuthUser);
      return Future.value();
    });

    when(
      () => mockUserRepository.getOrCreateUser(mockAuthUser),
    ).thenAnswer((_) => Future.value(userFromGithub));

    await userService.loginWithGithub(
      token: mockGithubToken,
    );
  }

  setUp(() {
    // ! we must recreate mockAuthUserStream to avoid any side effects between tests
    mockAuthUserStream = BehaviorSubject<AuthUser?>.seeded(null);
    when(
      () => mockAuthRepository.authUserStream,
    ).thenAnswer(
      (_) => mockAuthUserStream.stream,
    );
    mockAuthUserStream.drain();
    userService = UserService(
      userRepository: mockUserRepository,
      authRepository: mockAuthRepository,
      userStore: InMemoryStore<User?>(null),
    );
  });

  test(
    'it should be able to login with Google',
    () async {
      expectLater(
        userService.watchUser.where((event) => event != null).cast<User>(),
        emits(userFromGoogle),
      );

      await _loginWithGoogle();
    },
    timeout: const Timeout(Duration(milliseconds: 600)),
  );

  test(
    'it should be able to login with Github',
    () async {
      expectLater(
        userService.watchUser.where((event) => event != null).cast<User>(),
        emits(userFromGithub),
      );

      await _loginWithGithub();
    },
    timeout: const Timeout(Duration(milliseconds: 600)),
  );

  test('it should be able to sign out', () async {
    when(() => mockAuthRepository.signOut()).thenAnswer(
      (_) {
        mockAuthUserStream.add(null);
        return Future.value();
      },
    );

    expectLater(
      userService.watchUser.where((event) => event == null).cast<void>(),
      emitsInAnyOrder([null]),
    );

    await userService.signOut();
  });
}
