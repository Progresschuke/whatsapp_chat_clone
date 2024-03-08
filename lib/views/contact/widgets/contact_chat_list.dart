// import 'package:flutter/material.dart';
// import 'package:whatsapp_clone/data/dummy_users.dart';

// import 'contact_card.dart';

// class ContactList extends StatelessWidget {
//   const ContactList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: dummyusers.length,
//         itemBuilder: (context, index) {
//           String image = dummyusers[index]['image'].toString();
//           return ContactCard(
//             userName: dummyusers[index]['name'].toString(),
//             message: dummyusers[index]['message'].toString(),
//             time: dummyusers[index]['time'].toString(),
//             image: image == '' ? null : image,
//           );
//         });
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/widgets/loader.dart';
import '../../../model/chat_contact.dart';
import '../../chat/controller/chat_controller.dart';
import 'contact_card.dart';

class ContactChatList extends ConsumerWidget {
  const ContactChatList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<ChatContact>>(
        stream: ref.read(chatControllerProvider).getChatContactList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text('No chat yet'),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                ChatContact chatContactData = snapshot.data![index];
                return ContactCard(
                  contact: chatContactData,
                );
              });
        });
  }
}
