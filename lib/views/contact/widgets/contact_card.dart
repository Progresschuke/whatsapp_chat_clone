import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.userName,
    required this.message,
    required this.time,
    this.image,
  });

  final String userName;
  final String message;
  final String time;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFCED9DE),
        backgroundImage: image == null ? null : AssetImage(image!),
        child: image != null ? null : Text(getInitials(userName)),
      ),
      title: Text(userName),
      subtitle: Text(message),
      trailing: Text(time),
    );
  }

  String getInitials(String fullName) {
    var nameParts = fullName.split(' ');

    String initials = '';
    for (String firstLetter in nameParts) {
      initials += firstLetter[0];
    }
    return initials.toUpperCase();
  }
}
