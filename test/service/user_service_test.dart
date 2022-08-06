import 'package:core/model/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpaper/service/user_service.dart';
import 'package:fpaper/util/memory_store.dart';
import 'package:mocktail/mocktail.dart';

import 'mock/data.dart';

void main() {
  late final UserService userService;

  setUpAll(() {
    userService = UserService(
      userRepository: mockUserRepository,
      authRepository: mockAuthRepository,
      userStore: InMemoryStore<User?>(null),
    );
  });

  test('it should be able to login with Google', () async {
    when(
      () => mockAuthRepository.signUserWithGoogle(
        accessToken: mockGoogleAccessToken,
        idToken: mockGoogleIdToken,
      ),
    ).thenAnswer((_) => Future.value(authUserFromGoogle));

    when(
      () => mockUserRepository.getOrCreateUser(authUserFromGoogle),
    ).thenAnswer((_) => Future.value(userFromGoogle));

    await userService.loginWithGoogle(
      accessToken: mockGoogleAccessToken,
      idToken: mockGoogleIdToken,
    );

    final user = userService.currentUser;

    expect(user, isNotNull);
    expect(user?.id, userFromGoogle.id);
    expect(user?.username, userFromGoogle.username);

    expectLater(userService.watchUser, emits(userFromGoogle));
  });
}
