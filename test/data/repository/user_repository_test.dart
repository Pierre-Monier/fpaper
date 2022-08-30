import 'package:flutter_test/flutter_test.dart';
import 'package:fpaper/data/repository/user_repository.dart';
import 'package:mocktail/mocktail.dart';

import 'mock/data.dart';

void main() {
  late final UserRepository userRepository;

  setUpAll(() {
    userRepository = UserRepository(
      firestoreDatasource: mockFirestoreDatasource,
    );
  });

  test('it should get the user from db', () async {
    when(
      () => mockFirestoreDatasource.getUserById(id: mockAuthUser.uid),
    ).thenAnswer((_) => Future.value(userFromDbData));

    final user = await userRepository.getOrCreateUser(mockAuthUser);

    expect(user.username, userFromDbUsername);
    expect(user.profilPicturePath, userFromDbProfilPicturePath);
  });

  test('it should create and return user from if he is not in db', () async {
    when(
      () => mockFirestoreDatasource.getUserById(id: mockAuthUser.uid),
    ).thenAnswer((_) => Future.value());
    when(
      () => mockFirestoreDatasource.createUser(
        data: userRepository.authUserToMap(mockAuthUser),
        id: mockAuthUser.uid,
      ),
    ).thenAnswer((_) => Future.value(userCreatedData));

    final user = await userRepository.getOrCreateUser(mockAuthUser);

    expect(user.username, userCreatedUsername);
    expect(user.profilPicturePath, userCreatedProfilPicturePath);
  });

  test('it should be able to get a list of user from a username', () async {
    when(
      () => mockFirestoreDatasource.getUsersByUsername(mockUsername),
    ).thenAnswer((_) => Future.value([fullUserFromDbData]));

    final users = await userRepository.getUsersByUsername(mockUsername);

    expect(users.first.username, userFromDbUsername);
    expect(users.first.profilPicturePath, userFromDbProfilPicturePath);
  });
}
