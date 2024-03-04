// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:whatsapp_clone/enum/message.dart';

class MyMessage {
  final String msg;
  final String sent;
  final String read;
  final String fromId;
  final String toId;

  MyMessage({
    required this.msg,
    required this.sent,
    required this.read,
    required this.fromId,
    required this.toId,
  });
}

class Message {
  final String messageId;
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime timeSent;
  final MessageType messageType;
  final bool isSeen;
  Message({
    required this.messageId,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timeSent,
    required this.messageType,
    required this.isSeen,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messageId': messageId,
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'messageType': messageType.type,
      'isSeen': isSeen,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      messageId: map['messageId'] as String,
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
      message: map['message'] as String,
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent'] as int),
      messageType: (map['messageType'] as String).toEnum(),
      isSeen: map['isSeen'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);
}
