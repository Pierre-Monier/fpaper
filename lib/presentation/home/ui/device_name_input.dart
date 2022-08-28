import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpaper/providers.dart';

class DeviceNameInput extends ConsumerStatefulWidget {
  const DeviceNameInput({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DeviceNameListenerState();
}

class _DeviceNameListenerState extends ConsumerState<DeviceNameInput> {
  late final _textEditingController =
      TextEditingController(text: ref.read(deviceNameControllerProvider).name);

  @override
  Widget build(BuildContext context) {
    final deviceNameController =
        ref.watch(deviceNameControllerProvider.notifier);

    return TextField(
      controller: _textEditingController,
      onChanged: deviceNameController.onNameChanged,
    );
  }
}
