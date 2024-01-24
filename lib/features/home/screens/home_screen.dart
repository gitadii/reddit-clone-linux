import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redditclone_linux/features/auth/controller/auth_controller.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(leading: const Icon(Icons.menu),),
      body: Center(
        child : Text(user.name),
      ),
    );
  }
}