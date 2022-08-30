import 'package:auth/data/repository/auth_repository.dart';
import 'package:device_info/data/source/device_info_datasource.dart';
import 'package:fpaper/data/repository/device_repository.dart';
import 'package:fpaper/data/repository/friend_repository.dart';
import 'package:fpaper/data/repository/user_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notification/data/source/notification_datasource.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockDeviceRepository extends Mock implements DeviceRepository {}

class MockDeviceInfoDatasource extends Mock implements DeviceInfoDatasource {}

class MockNotificationDatasource extends Mock
    implements NotificationDatasource {}

class MockFriendRepository extends Mock implements FriendRepository {}
