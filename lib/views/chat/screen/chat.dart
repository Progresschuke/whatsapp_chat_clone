// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/widgets/loader.dart';

import '../../../constants/app_colors.dart';
import '../../../enum/message.dart';
import '../../../model/user.dart';
import '../../../providers/chat/chat_provider.dart';
import '../../../utils/size/size_const.dart';
import '../../../utils/utils.dart';
import '../../auth/controller/auth_controller.dart';
import '../../contact/widgets/user_profile.dart';
import '../controller/chat_controller.dart';
import '../widgets/user_chat.dart';

class ChatScreen extends ConsumerStatefulWidget {
  static const routeName = '/chat';
  const ChatScreen({
    Key? key,
    required this.name,
    required this.uid,
  }) : super(key: key);

  final String name;
  final String uid;

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

//added the widgetsBindingObserver to monitor states
class _ChatScreenState extends ConsumerState<ChatScreen>
    with WidgetsBindingObserver {
  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).setUserState(true);
        break;
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        ref.read(authControllerProvider).setUserState(false);
        break;
    }
  }

  void sendTextMessage() async {
    final showSendButton = ref.watch(sendTextProvider);
    if (showSendButton) {
      ref.read(chatControllerProvider).sendTextMessage(
            context: context,
            text: messageController.text.trim(),
            receiverUserId: widget.uid,
          );
      messageController.clear();
    }
  }

  void sendFileMessage({
    required File file,
    required MessageType messageType,
  }) {
    ref.read(chatControllerProvider).sendFileMessages(
        context: context,
        file: file,
        receiverId: widget.uid,
        messageType: messageType);
  }

  void sendImageFile() async {
    final image = await pickImageFromGallery(context);
    if (image != null) {
      sendFileMessage(
        file: image,
        messageType: MessageType.image,
      );
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: chatAppBar(),
        body: Column(
          children: [
            Expanded(
                child: UserChat(
              contactId: widget.uid,
            )),
            userInputForm(),
          ],
        ));
  }

  PreferredSizeWidget chatAppBar() {
    return AppBar(
      title: StreamBuilder(
        stream: ref.read(authControllerProvider).getUserSnapshot(widget.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }

          if (!snapshot.hasData) {
            return const SizedBox();
          }
          UserModel chatUserData = snapshot.data!;

          return Row(
            children: [
              UserProfilePics(
                userName: chatUserData.name,
                userProfilePic: chatUserData.profile,
              ),
              SizeConst.addHorizontalSpace(context, 0.02),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  widget.name,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white, fontSize: 18),
                ),
                Text(
                  snapshot.data!.isOnline ? 'Online' : 'Offline',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 16, color: Colors.white),
                ),
              ]),
            ],
          );
        },
      ),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
      ],
    );
  }

  Widget userInputForm() {
    final showSendButton = ref.watch(sendTextProvider);

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
                Expanded(
                    child: TextFormField(
                  controller: messageController,
                  decoration: InputDecoration(
                    prefixIcon: ChatIconButton(
                      onPressed: () {},
                      icon: Icons.emoji_emotions_outlined,
                    ),
                    hintText: 'Message',
                    hintStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      ref.read(sendTextProvider.notifier).sendTextTrue();
                    } else {
                      ref.read(sendTextProvider.notifier).sendTextFalse();
                    }
                  },
                )),
                ChatIconButton(
                  onPressed: () {},
                  icon: Icons.attach_file,
                ),
                SizeConst.addHorizontalSpace(context, .001),
                ChatIconButton(
                  onPressed: sendImageFile,
                  icon: Icons.camera_alt_rounded,
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
            child: GestureDetector(
              onTap: sendTextMessage,
              child: Icon(
                showSendButton ? Icons.send : Icons.mic,
                color: Colors.white,
              ),
            ),
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
