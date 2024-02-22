import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/widgets/loader.dart';
import '../../error/error.dart';
import '../controller/select_contact_controller.dart';
import '../widgets/select_contact_list.dart';

class SelectContactScreen extends ConsumerWidget {
  static const routeName = '/select_contact';
  const SelectContactScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: selectContactPageAction(),
        body: ref.watch(getContactsProvider).when(
              data: (contacts) {
                return ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    final contact = contacts[index];
                    return SelectContactList(contact: contact);
                  },
                );
              },
              error: (error, stackTrace) =>
                  ErrorScreen(error: error.toString()),
              loading: () => const Loader(),
            ));
  }

  PreferredSizeWidget? selectContactPageAction() {
    return AppBar(title: const Text('Select Contact'), actions: [
      IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
      IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
    ]);
  }
}
