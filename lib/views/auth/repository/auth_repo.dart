import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/otp.dart';

final authRepoProvider = Provider((ref) {
  return AuthRepository(
      auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance);
});

class AuthRepository {
  AuthRepository({
    required this.auth,
    required this.firestore,
  });
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  signInWithPhoneNumber(BuildContext context, String phoneNumber) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print('=================================');
          print(e.message);
          print('=================================');
          throw Exception(e.message);
        },
        codeSent: (String verificationId, int? resendToken) async {
          print('=================================');
          print(verificationId);
          print('=================================');
          Navigator.pushNamed(context, OtpScreen.routeName,
              arguments: verificationId);
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: $e');
      return e.message;
    }
  }

  verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
  }) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);

      await auth.signInWithCredential(credential);

      // if (context.mounted) {
      //   Navigator.pushNamed(context, SuccessScreen.routeName);
      // }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
