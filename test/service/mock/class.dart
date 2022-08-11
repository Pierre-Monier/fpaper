import 'package:auth/data/repository/auth_repository.dart';
import 'package:device_info/data/source/device_info_datasource.dart';
import 'package:fpaper/data/repository/device_repository.dart';
import 'package:fpaper/data/repository/user_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockDeviceRepository extends Mock implements DeviceRepository {}

class MockDeviceInfoDatasource extends Mock implements DeviceInfoDatasource {}
