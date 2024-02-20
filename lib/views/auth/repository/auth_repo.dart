import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/repositories/firebase_storage_repo.dart';
import '../../../constants/app_images.dart';
import '../../../model/user.dart';
import '../../../utils/utils.dart';
import '../../contact/screen/contact.dart';
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

  saveUserDataToFirebase({
    required BuildContext context,
    required String name,
    required File? profileImage,
    required ProviderRef ref,
  }) async {
    String profileUrl = AppImages.defaultProfile;
    final userUid = auth.currentUser!.uid;

    try {
      if (profileImage != null) {
        profileUrl = await ref
            .read(commonFirebaseStorageRepository)
            .storeFileToFirebase('profile/$userUid', profileImage);
      }

      var user = UserModel(
          uid: userUid,
          name: name,
          profile: profileUrl,
          isOnline: true,
          phoneNumber: auth.currentUser!.uid,
          groupId: []);

      //save userdata to firestore
      await firestore.collection('user').doc(userUid).set(user.toMap());
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, ContactScreen.routeName, (route) => false);
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context: context, error: e.toString());
      }
    }
  }

  Future<UserModel?> getCurrentUserData() async {
    var userData =
        await firestore.collection('user').doc(auth.currentUser?.uid).get();
    UserModel? user;

    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }
}
