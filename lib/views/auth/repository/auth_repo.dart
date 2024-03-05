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

  void signInWithPhoneNumber(BuildContext context, String phoneNumber) async {
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
      if (context.mounted) {
        showSnackBar(context: context, error: e.message!);
      }
    }
  }

  void verifyOtp({
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
      if (context.mounted) {
        showSnackBar(context: context, error: e.message!);
      }
    }
  }

  void saveUserDataToFirebase({
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
        phoneNumber: auth.currentUser!.phoneNumber!,
        // groupId: [],
      );

      //save userdata to firestore
      await firestore.collection('users').doc(userUid).set(user.toMap());
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

//determines if a user has been signed in or not to display either the chatscreen or landing page
  Future<UserModel?> getCurrentUserData() async {
    var userData =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();
    UserModel? user;

    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

//to get snapshot of chatusers which determines if a user is online or offline
  Stream<UserModel> userSnapshotById(String uid) {
    return firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((event) => UserModel.fromMap(event.data()!));
  }
}
