import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constants/app_colors.dart';

import '../../../model/user.dart';
import '../../contact/widgets/user_profile.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          UserProfilePics(user: user),
          Text(
            user.userName,
          ),
          // space(context, figure),
          IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ]),
      ),
      body: Center(
          child: Text(
        user.userName,
        style: Theme.of(context).textTheme.titleLarge,
      )),
    );
  }
}
