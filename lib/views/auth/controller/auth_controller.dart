import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/views/auth/screens/otp.dart';

import '../repository/auth_repo.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepoProvider);
  return AuthController(authRepository: authRepository);
});

class AuthController {
  AuthController({required this.authRepository});
  final AuthRepository authRepository;

  signInWithPhoneNumber(BuildContext context, String phoneNumber) {
    Navigator.pushNamed(context, OtpScreen.routeName);
  }
}
