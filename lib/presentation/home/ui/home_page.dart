import 'package:flutter/material.dart';
import 'package:fpaper/presentation/home/ui/tmp_to_remove_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: TmpToRemoveWidget(),
      ),
    );
  }
}
