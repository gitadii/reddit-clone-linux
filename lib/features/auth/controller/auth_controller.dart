import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redditclone_linux/features/auth/repository/auth_repository.dart';
import 'package:redditclone_linux/core/showSnackBar.dart';
import 'package:redditclone_linux/model/user_model.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref
  ),
);

// Creating the StreamProviders for the Streams
final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

class AuthController extends StateNotifier<bool> {
  final Ref _ref;
  final AuthRepository _authRepository;

  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
      _ref = ref,
      super(false);

      // Consuming the streams from auth_repository in auth_controller to create the StreamProvider for them
      Stream<User?> get authStateChange => _authRepository.authStateChange;

      Stream<UserModel> getUserData(String uid) {
        return _authRepository.getUserData(uid);
      }

  void signInWithGoogle(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInWithGoogle();
    state = false;
    user.fold(
      (l) => showSnackBar(context, l.mssg), 
    (userModel) => _ref.read(userProvider.notifier).update((state) => userModel),
    );

  }
}
