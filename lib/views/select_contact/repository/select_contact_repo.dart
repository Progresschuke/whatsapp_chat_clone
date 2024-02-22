import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/model/user.dart';
import 'package:whatsapp_clone/utils/utils.dart';

final selectContactRepoProvider = Provider(
    (ref) => SelectContactRepository(firestore: FirebaseFirestore.instance));

class SelectContactRepository {
  SelectContactRepository({required this.firestore});

  final FirebaseFirestore firestore;

  Future<List<Contact>> getContacts() async {
    List<Contact> userContacts = [];

    try {
      if (await FlutterContacts.requestPermission()) {
        // Get all contacts (fully fetched)
        userContacts = await FlutterContacts.getContacts(
            withProperties: true, withPhoto: true);
      }
    } catch (e) {
      // showSnackBar(context: context, error: e.toString());
      debugPrint(e.toString());
    }

    return userContacts;
  }

  void selectContact(
      {required Contact selectedContact, required BuildContext context}) async {
    try {
      bool isFound = false;
      var userCollection = await firestore.collection('users').get();

      for (var document in userCollection.docs) {
        var userData = UserModel.fromMap(document.data());
        print(selectedContact.phones);
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context: context, error: e.toString());
      }
    }
  }
}
