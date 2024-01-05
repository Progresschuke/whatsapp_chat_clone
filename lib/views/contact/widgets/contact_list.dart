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
import 'package:whatsapp_clone/data/dummy_users.dart';
import 'package:whatsapp_clone/model/user.dart';

import 'contact_card.dart';

class ContactList extends StatelessWidget {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: dummyusers.length,
        itemBuilder: (context, index) {
          User user = dummyusers[index];
          return ContactCard(
            user: user,
          );
        });
  }
}
