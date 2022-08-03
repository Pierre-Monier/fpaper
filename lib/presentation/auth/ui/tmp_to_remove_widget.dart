import 'package:core/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpaper/providers.dart';

class TmpToRemoveWidget extends ConsumerWidget {
  const TmpToRemoveWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRepository = ref.read(userRepositoryProvider);
    return StreamBuilder<User?>(
      stream: userRepository.watchUser,
      builder: (context, snapshot) {
        final user = snapshot.data;

        if (snapshot.hasError) {
          return const Text("Shit happens");
        } else if (user == null) {
          return const Text("No user");
        }

        return Column(
          children: [
            CircleAvatar(
              foregroundImage: user.profilPicturePath != null
                  ? NetworkImage(user.profilPicturePath!)
                  : null,
            ),
            Text(user.username),
          ],
        );
      },
    );
  }
}
