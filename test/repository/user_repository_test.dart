import 'package:flutter_test/flutter_test.dart';
import 'package:fpaper/repository/user_repository.dart';
import 'package:mocktail/mocktail.dart';

import 'mock/data.dart';

void main() {
  test('it should get the user from db', () async {
    final userRepository = UserRepository(
      firestoreDatasource: mockFirestoreDatasource,
    );

    when(
      () => mockFirestoreDatasource.getUserById(id: mockAuthUser.uid),
    ).thenAnswer((_) => Future.value(userFromDbData));

    final user = await userRepository.getOrCreateUser(mockAuthUser);

    expect(user.username, userFromDbUsername);
    expect(user.profilPicturePath, userFromDbProfilPicturePath);
  });

  test('it should create and return user from if he is not in db', () async {
    final userRepository = UserRepository(
      firestoreDatasource: mockFirestoreDatasource,
    );

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
}
