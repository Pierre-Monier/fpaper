import 'package:auth/data/repository/auth_repository.dart';
import 'package:fpaper/data/repository/user_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockAuthRepository extends Mock implements AuthRepository {}
