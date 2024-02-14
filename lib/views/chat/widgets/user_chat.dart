import 'package:flutter/material.dart';
import 'package:whatsapp_clone/data/dummy_users.dart';

import 'message_card.dart';

class UserChat extends StatelessWidget {
  const UserChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: chatMsgs.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return MessageCard(
            message: chatMsgs[index],
          );
        },
      ),
    );
  }
}
