import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/views/auth/screens/otp.dart';

import '../../../utils/utils.dart';
import '../repository/auth_repo.dart';
import '../screens/user_info.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepoProvider);
  return AuthController(authRepository: authRepository);
});

class AuthController {
  AuthController({required this.authRepository});
  final AuthRepository authRepository;

  void signInWithPhoneNumber(BuildContext context, String phoneNumber) {
    authRepository.signInWithPhoneNumber(context, phoneNumber);
    Navigator.pushNamed(context, OtpScreen.routeName);
  }

  verifyOtp(
      {required BuildContext context,
      required String? verificationId,
      required String? userOtp}) {
    if (verificationId == null || userOtp == null) {
      showSnackBar(context: context, error: 'Enter a valid OTP');
      return;
    }

    try {
      //add loader message
      authRepository.verifyOtp(
          context: context, verificationId: verificationId, userOtp: userOtp);
      Navigator.pushNamedAndRemoveUntil(
          context, UserInfoScreen.routeName, (route) => false);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
