import 'package:flutter/material.dart';
import 'package:fpaper/presentation/home/ui/device_name_input.dart';
import 'package:ui/widget/app_primary_button.dart';

class DeviceNameForm extends StatelessWidget {
  const DeviceNameForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DeviceNameInput(),
        AppPrimaryButton(
          onPressed: () {
            // * we are just poping the dialog
            // * the logic is trigger when the dialog is pop to handle every case
            // ! we can't use GoRouter.of(context).pop() because it will try to
            // ! pop the entiere page
            Navigator.of(context).pop();
          },
          child: const Text("Valider"),
        )
      ],
    );
  }
}
