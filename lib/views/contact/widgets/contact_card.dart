// import 'package:flutter/material.dart';

// import '../../chat/screen/chat.dart';

// class ContactCard extends StatelessWidget {
//   const ContactCard({
//     super.key,
//     required this.userName,
//     required this.message,
//     required this.time,
//     this.image,
//   });

//   final String userName;
//   final String message;
//   final String time;
//   final String? image;

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (ctx) => ChatScreen(
//                       userName: userName,
//                     )));
//       },
//       leading: CircleAvatar(
//         backgroundColor: const Color(0xFFCED9DE),
//         backgroundImage: image == null ? null : AssetImage(image!),
//         child: image != null ? null : Text(getInitials(userName)),
//       ),
//       title: Text(userName),
//       subtitle: Text(message),
//       trailing: Text(time),
//     );
//   }

//   String getInitials(String fullName) {
//     var nameParts = fullName.split(' ');

//     String initials = '';
//     for (String eachName in nameParts) {
//       initials += eachName[0];
//     }
//     return initials.toUpperCase();
//   }
// }

import 'package:flutter/material.dart';

import '../../../model/user.dart';
import '../../chat/screen/chat.dart';
import 'user_profile.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => ChatScreen(
                      user: user,
                    )));
      },
      leading: UserProfilePics(user: user),
      title: Text(user.userName),
      subtitle: Text(user.message),
      trailing: Text(user.sent),
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
