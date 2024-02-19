import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constants/app_colors.dart';

import '../../../model/user.dart';
import '../../../utils/size/size_const.dart';
import '../../contact/widgets/user_profile.dart';
import '../widgets/user_chat.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/chat';
  const ChatScreen({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: chatAppBar(context),
        body: Column(
          children: [
            const Expanded(child: UserChat()),
            userInputForm(context),
          ],
        ));
  }

  PreferredSizeWidget chatAppBar(BuildContext context) {
    return AppBar(
      title: Row(children: [
        UserProfilePics(user: user),
        SizeConst.addHorizontalSpace(context, 0.02),
        Text(
          user.userName,
        ),
        const Spacer(),
        IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
      ]),
    );
  }

  Widget userInputForm(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: SizeConst.customHeight(context, .008),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: SizeConst.customWidth(context, .78),
            height: SizeConst.customHeight(context, .06),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                ChatIconButton(
                  onPressed: () {},
                  icon: Icons.emoji_emotions_outlined,
                ),
                Expanded(
                    child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Message',
                    hintStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                    border: InputBorder.none,
                  ),
                )),
                ChatIconButton(
                  onPressed: () {},
                  icon: Icons.attach_file,
                ),
                SizeConst.addHorizontalSpace(context, .001),
                ChatIconButton(
                  onPressed: () {},
                  icon: Icons.camera_alt_outlined,
                ),
              ],
            ),
          ),
          Container(
            height: SizeConst.customHeight(context, .06),
            width: SizeConst.customWidth(context, .14),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColorsLight.appBarColor,
            ),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.mic,
                  color: Colors.white,
                )),
          )
        ],
      ),
    );
  }
}

class ChatIconButton extends StatelessWidget {
  const ChatIconButton(
      {super.key, required this.onPressed, required this.icon});

  final void Function()? onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: Colors.grey,
      ),
    );
  }
}
