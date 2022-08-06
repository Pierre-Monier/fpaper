import 'package:core/model/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpaper/service/user_service.dart';
import 'package:fpaper/util/memory_store.dart';
import 'package:mocktail/mocktail.dart';

import 'mock/data.dart';

void main() {
  late final UserService userService;

  Future<void> _loginWithGoogle() async {
    when(
      () => mockAuthRepository.signUserWithGoogle(
        accessToken: mockGoogleAccessToken,
        idToken: mockGoogleIdToken,
      ),
    ).thenAnswer((_) {
      mockAuthUserStream.add(authUserFromGoogle);
      return Future.value();
    });

    when(
      () => mockUserRepository.getOrCreateUser(authUserFromGoogle),
    ).thenAnswer((_) => Future.value(userFromGoogle));

    await userService.loginWithGoogle(
      accessToken: mockGoogleAccessToken,
      idToken: mockGoogleIdToken,
    );
  }

  setUpAll(() {
    when(
      () => mockAuthRepository.authUserStream,
    ).thenAnswer(
      (_) => mockAuthUserStream.stream,
    );
    when(() => mockAuthRepository.signOut()).thenAnswer(
      (_) {
        mockAuthUserStream.add(null);
        return Future.value();
      },
    );

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

  test('it should be able to sign out', () async {
    expectLater(
      userService.watchUser.where((event) => event == null).cast<void>(),
      emitsInAnyOrder([null]),
    );

    await userService.signOut();
  });
}
