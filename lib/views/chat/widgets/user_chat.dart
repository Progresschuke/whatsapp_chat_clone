import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/widgets/loader.dart';
import '../../../model/message.dart';
import '../controller/chat_controller.dart';
import 'message_card.dart';

class UserChat extends ConsumerStatefulWidget {
  const UserChat({super.key, required this.contactId});

  final String contactId;

  @override
  ConsumerState<UserChat> createState() => _UserChatState();
}

class _UserChatState extends ConsumerState<UserChat> {
  ScrollController messageScrollController = ScrollController();

  @override
  void dispose() {
    messageScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder<List<Message>>(
          stream:
              ref.read(chatControllerProvider).chatMessages(widget.contactId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loader();
            }
            if (!snapshot.hasData) {
              return const Center(
                child: Text('No chat messages'),
              );
            }
            //for automatic scrolling effect
            SchedulerBinding.instance.addPostFrameCallback((_) {
              messageScrollController
                  .jumpTo(messageScrollController.position.maxScrollExtent);
            });
            List<Message> chatMessages = snapshot.data!;
            return ListView.builder(
              controller: messageScrollController,
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return MessageCard(
                  message: chatMessages[index],
                  contactId: widget.contactId,
                );
              },
            );
          }),
    );
  }
}
