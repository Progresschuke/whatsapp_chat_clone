import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/select_contact_repo.dart';

//Here, we do not need to interact with the UI
final getContactsProvider = FutureProvider((ref) {
  final selectContactRepo = ref.watch(selectContactRepoProvider);

  return selectContactRepo.getContacts();
});

//to get details of contact when a user selects a particular contact
final selectContactControllerProvider = Provider((ref) {
  final selectContactRepository = ref.watch(selectContactRepoProvider);
  return SelectContactController(
      ref: ref, selectContactRepository: selectContactRepository);
});

class SelectContactController {
  SelectContactController(
      {required this.ref, required this.selectContactRepository});

  final ProviderRef ref;
  final SelectContactRepository selectContactRepository;

  void selectContact(
      {required Contact selectedContact, required BuildContext context}) {
    selectContactRepository.selectContact(
        selectedContact: selectedContact, context: context);
  }
}
