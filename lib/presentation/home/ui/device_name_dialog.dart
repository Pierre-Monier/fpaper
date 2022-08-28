import 'package:flutter/material.dart';
import 'package:fpaper/presentation/home/ui/device_name_form.dart';

class DeviceNameDialog extends StatelessWidget {
  const DeviceNameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      child: DeviceNameForm(),
    );
  }
}
