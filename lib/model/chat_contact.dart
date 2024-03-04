// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatContact {
  final String contactId;
  final String profilePic;
  final String lastMessage;
  final String name;
  final DateTime timeSent;
  ChatContact({
    required this.contactId,
    required this.profilePic,
    required this.lastMessage,
    required this.name,
    required this.timeSent,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'contactId': contactId,
      'profilePic': profilePic,
      'lastMessage': lastMessage,
      'name': name,
      'timeSent': timeSent.millisecondsSinceEpoch,
    };
  }

  factory ChatContact.fromMap(Map<String, dynamic> map) {
    return ChatContact(
      contactId: map['contactId'] as String,
      profilePic: map['profilePic'] as String,
      lastMessage: map['lastMessage'] as String,
      name: map['name'] as String,
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatContact.fromJson(String source) =>
      ChatContact.fromMap(json.decode(source) as Map<String, dynamic>);
}
