import 'package:auth/model/auth_user.dart';
import 'package:core/model/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpaper/service/user_service.dart';
import 'package:fpaper/util/memory_store.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/subjects.dart';

import 'mock/data.dart';
import 'user_service_robot.dart';

late UserService userService;
late BehaviorSubject<AuthUser?> mockAuthUserStream;
final userServiceRobot = UserServiceRobot();

void main() {
  setUpAll(() {
    when(
      () => mockDeviceRepository.getUserDevices(userId: mockAuthUserUid),
    ).thenAnswer((_) => Future.value(mockUserDevices));
    when(
      () => mockDeviceInfoDatasource.getDeviceId(),
    ).thenAnswer((_) => Future.value(mockUserDevices.first.id));
  });

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
      deviceRepository: mockDeviceRepository,
      deviceInfoDatasource: mockDeviceInfoDatasource,
      userStore: InMemoryStore<User?>(null),
      shouldRegisterDeviceStore: InMemoryStore<bool>(false),
    );
  });

  test(
    'it should be able to login with Google',
    () async {
      expectLater(
        userService.watchUser.where((event) => event != null).cast<User>(),
        emits(
          predicate<User>((user) {
            return userServiceRobot.compareUserWithWantedUser(
              user: user,
              wantedUser: userFromGoogle,
            );
          }),
        ),
      );

      await userServiceRobot.loginWithGoogle();
    },
    timeout: const Timeout(Duration(milliseconds: 600)),
  );

  test(
    'it should be able to login with Github',
    () async {
      expectLater(
        userService.watchUser.where((event) => event != null).cast<User>(),
        emits(
          predicate<User>((user) {
            return userServiceRobot.compareUserWithWantedUser(
              user: user,
              wantedUser: userFromGithub,
            );
          }),
        ),
      );

      await userServiceRobot.loginWithGithub();
    },
    timeout: const Timeout(Duration(milliseconds: 600)),
  );

  test(
    "it should set shouldRegisterDevice to true when the current device isn't inside user's devices",
    () async {
      when(
        () => mockDeviceRepository.getUserDevices(userId: mockAuthUserUid),
      ).thenAnswer((_) => Future.value([]));

      expectLater(
        userService.watchShouldRegisterDevice,
        emitsInOrder([false, true]),
      );

      await userServiceRobot.loginWithGithub();
    },
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

  test('it should be able to register device', () async {
    when(() => mockDeviceInfoDatasource.getDeviceName())
        .thenAnswer((_) => Future.value(mockDeviceName));
    when(
      () => mockDeviceRepository.createDevice(
        userId: userFromGoogle.id,
        deviceName: mockDeviceName,
        registrationToken: "toto",
      ),
    ).thenAnswer((_) => Future.value(mockDevice));

    expectLater(
      userService.watchUser
          .where((user) => user != null && user.devices.isNotEmpty)
          .cast<User>(),
      emits(
        predicate<User>((user) {
          return user.devices.first == mockDevice;
        }),
      ),
    );

    await userServiceRobot.loginWithGoogle();
    await userService.registerUserDevice();
  });
}
