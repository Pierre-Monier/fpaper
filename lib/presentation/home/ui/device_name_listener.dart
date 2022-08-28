import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpaper/presentation/home/ui/device_name_dialog.dart';
import 'package:fpaper/providers.dart';

class DeviceNameListener extends ConsumerStatefulWidget {
  const DeviceNameListener({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DeviceNameListenerState();
}

class _DeviceNameListenerState extends ConsumerState<DeviceNameListener> {
  @override
  void initState() {
    super.initState();
    final deviceNameController =
        ref.read(deviceNameControllerProvider.notifier);
    deviceNameController.watchShouldRegisterDevice
        .listen((shouldRegisterDevice) async {
      if (shouldRegisterDevice) {
        await showDialog(
          context: context,
          builder: (context) => const DeviceNameDialog(),
        );

        deviceNameController.registerDevice();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
