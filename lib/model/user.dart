import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String userName;
  final String id;
  String? image;
  final String message;
  final String sent;

  User({
    required this.userName,
    required this.id,
    this.image,
    required this.message,
    required this.sent,
  });
}

class UserModel {
  final String uid;
  final String name;
  final String profile;
  final bool isOnline;
  final String phoneNumber;
  final List<String> groupId;

  UserModel({
    required this.uid,
    required this.name,
    required this.profile,
    required this.isOnline,
    required this.phoneNumber,
    required this.groupId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'profile': profile,
      'isOnline': isOnline,
      'phoneNumber': phoneNumber,
      'groupId': groupId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        uid: map['uid'] as String,
        name: map['name'] as String,
        profile: map['profile'] as String,
        isOnline: map['isOnline'] as bool,
        phoneNumber: map['phoneNumber'] as String,
        groupId: List<String>.from(
          (map['groupId'] as List<String>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
