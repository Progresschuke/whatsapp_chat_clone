import 'package:flutter/material.dart';

import '../../../model/user.dart';

class UserProfilePics extends StatelessWidget {
  const UserProfilePics({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: const Color(0xFFCED9DE),
      backgroundImage: user.image == null ? null : AssetImage(user.image!),
      child: user.image != null ? null : Text(getInitials(user.userName)),
    );
  }

  String getInitials(String fullName) {
    var nameParts = fullName.split(' ');

    String initials = '';
    for (String eachName in nameParts) {
      initials += eachName[0];
    }
    return initials.toUpperCase();
  }
}
