import 'package:flutter/material.dart';

class UserProfilePics extends StatelessWidget {
  const UserProfilePics({
    super.key,
    required this.userProfilePic,
    required this.userName,
  });

  final String userProfilePic;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: const Color(0xFFCED9DE),
      backgroundImage: !userProfilePic.contains('http')
          ? null
          : NetworkImage(userProfilePic),
      child:
          userProfilePic.contains('http') ? null : Text(getInitials(userName)),
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
