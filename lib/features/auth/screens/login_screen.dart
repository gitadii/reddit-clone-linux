import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redditclone_linux/core/commons/loader.dart';
import 'package:redditclone_linux/core/commons/sign_in_button.dart';
import 'package:redditclone_linux/core/constants/constants.dart';
import 'package:redditclone_linux/features/auth/controller/auth_controller.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 170.0),
          child: Image.asset(
            Constants.logoPath,
            height: 40,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'skip',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      body: isLoading? const Loader() : Column(
        children: [
          const SizedBox(
            height: 40.0,
          ),
          const Text(
            "Dive into anything",
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              Constants.loginEmotePath,
              height: 400,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          SignInButton(),
        ],
      ),
    );
  }
}
