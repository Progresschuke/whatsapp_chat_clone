// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/model/chat_contact.dart';
import 'package:whatsapp_clone/model/message.dart';
import 'package:whatsapp_clone/views/auth/controller/auth_controller.dart';

import 'package:whatsapp_clone/views/chat/repository/chat_repo.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(chatRepository: chatRepository, ref: ref);
});

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;
  ChatController({
    required this.chatRepository,
    required this.ref,
  });

  void sendTextMessage(
      {required BuildContext context,
      required String text,
      required String receiverUserId}) {
    ref.watch(userDataProvider).whenData((value) {
      chatRepository.sendTextMessage(
          context: context,
          text: text,
          senderUser: value!,
          receiverUserId: receiverUserId);
    });
  }

  Stream<List<ChatContact>> getChatContactList() {
    return chatRepository.getChatContactList();
  }

  Stream<List<Message>> chatMessages(String contactId) {
    return chatRepository.getChatMessages(contactId);
  }
}
