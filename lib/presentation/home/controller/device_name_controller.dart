import 'package:device_info/data/source/device_info_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpaper/presentation/home/controller/device_name_state.dart';
import 'package:fpaper/service/user_service.dart';

class DeviceNameController extends StateNotifier<DeviceNameState> {
  DeviceNameController({
    required UserService userService,
    required DeviceInfoDatasource deviceInfoDatasource,
  })  : _userService = userService,
        _deviceInfoDatasource = deviceInfoDatasource,
        super(
          const DeviceNameState(name: ""),
        );

  Future<void> initialize() async {
    final deviceName = await _deviceInfoDatasource.getDeviceName();
    state = state.copyWith(name: deviceName);
  }

  final UserService _userService;
  final DeviceInfoDatasource _deviceInfoDatasource;

  void registerDevice() {
    throw UnimplementedError();
  }

  void onNameChanged(String name) {
    state = state.copyWith(name: name);
  }

  Stream<bool> get watchShouldRegisterDevice =>
      _userService.watchShouldRegisterDevice;
}
