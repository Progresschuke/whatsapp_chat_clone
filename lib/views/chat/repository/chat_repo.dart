import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_clone/enum/message.dart';
import 'package:whatsapp_clone/model/chat_contact.dart';
import 'package:whatsapp_clone/model/message.dart';
import 'package:whatsapp_clone/utils/utils.dart';

import '../../../model/user.dart';

final chatRepositoryProvider = Provider((ref) => ChatRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class ChatRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  ChatRepository({
    required this.auth,
    required this.firestore,
  });

//for the display of lastMessage and every other info on the contact screen
  void _saveDataToContactSubCollection({
    required UserModel senderUserData,
    required UserModel receiverUserData,
    required DateTime timeSent,
    required String message,
    required String receiverId,
  }) async {
    //receiver version
    //users ==> receiverId ==> //chats ==> senderId(current user ID) ==> store data

    var receiverChatContact = ChatContact(
      contactId: senderUserData.uid,
      profilePic: senderUserData.profile,
      name: senderUserData.name,
      timeSent: timeSent,
      lastMessage: message,
    );

    await firestore
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .set(receiverChatContact.toMap());

    //sender version
    //users ==> senderId(current user ID) ==> //chats ==> receiverId ==> store data

    var senderChatContact = ChatContact(
      contactId: receiverUserData.uid,
      profilePic: receiverUserData.profile,
      name: receiverUserData.name,
      timeSent: timeSent,
      lastMessage: message,
    );

    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .set(senderChatContact.toMap());
  }

//for the display of chatMessages on the chat screen
  void _saveMessageToMessageSubCollection({
    required String receiverId,
    required String message,
    required DateTime timeSent,
    required String messageId,
    required MessageType messageType,
    required String senderUsername,
    required String receiverUsername,
  }) async {
    var userMessage = Message(
        messageId: messageId,
        senderId: auth.currentUser!.uid,
        receiverId: receiverId,
        message: message,
        timeSent: timeSent,
        messageType: messageType,
        isSeen: false);

    //sender version
    //users ==> senderId(current user ID) ==> //chats ==> receiverId ==> //messages ==> messageId ==> store data

    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .doc(messageId)
        .set(userMessage.toMap());

    //receiver version
    //users ==> receiverId   ==> //chats ==> senderId(current user ID) ==> //messages ==> messageId ==> store data
    await firestore
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .collection('messages')
        .doc(messageId)
        .set(userMessage.toMap());
  }

  void sendTextMessage({
    required BuildContext context,
    required String text,
    required UserModel senderUser,
    required String receiverUserId,
  }) async {
    try {
      var messageId = const Uuid().v1();
      var timeSent = DateTime.now();
      UserModel receiverUser;
      var receiverUserData =
          await firestore.collection('users').doc(receiverUserId).get();
      receiverUser = UserModel.fromMap(receiverUserData.data()!);

      //users ==> senderId ==> //chat ==> receiverId ==> //messages ==> messageId ==> storeData
      _saveDataToContactSubCollection(
        senderUserData: senderUser,
        receiverUserData: receiverUser,
        message: text,
        receiverId: receiverUserId,
        timeSent: timeSent,
      );

      _saveMessageToMessageSubCollection(
        senderUsername: senderUser.name,
        receiverUsername: receiverUser.name,
        receiverId: receiverUserId,
        message: text,
        timeSent: timeSent,
        messageId: messageId,
        messageType: MessageType.text,
      );
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context: context, error: e.toString());
      }
    }
  }

  Stream<List<ChatContact>> getChatContactList() {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .asyncMap((event) async {
      List<ChatContact> contactList = [];
      for (var document in event.docs) {
        var chatContact = ChatContact.fromMap(document.data());

        //add to contact list directly or get chatUserData using the next method
        // contactList.add(chatContact);

        //or======================Use this method to get details from the chat user details
        var chatUserData = await firestore
            .collection('users')
            .doc(chatContact.contactId)
            .get();
        var user = UserModel.fromMap(chatUserData.data()!);

        contactList.add(ChatContact(
            contactId: user.uid,
            profilePic: user.profile,
            lastMessage: chatContact.lastMessage,
            name: user.name,
            timeSent: chatContact.timeSent));
      }

      return contactList;
    });
  }

  Stream<List<Message>> getChatMessages(String contactId) {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(contactId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      List<Message> chatMessages = [];
      for (var chatMessage in event.docs) {
        var message = Message.fromMap(chatMessage.data());

        chatMessages.add(message);
      }
      return chatMessages;
    });
  }
}
