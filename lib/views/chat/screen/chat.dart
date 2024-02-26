// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';

// import 'package:whatsapp_clone/constants/app_colors.dart';

// import '../../../model/user.dart';
// import '../../../utils/size/size_const.dart';
// import '../../contact/widgets/user_profile.dart';
// import '../widgets/user_chat.dart';

// class ChatScreen extends StatelessWidget {
//   static const routeName = '/chat';
//   const ChatScreen({
//     Key? key,
//     required this.user,
//   }) : super(key: key);

//   final User user;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Theme.of(context).primaryColor,
//         appBar: chatAppBar(context),
//         body: Column(
//           children: [
//             const Expanded(child: UserChat()),
//             userInputForm(context),
//           ],
//         ));
//   }

//   PreferredSizeWidget chatAppBar(BuildContext context) {
//     return AppBar(
//       title: Row(children: [
//         UserProfilePics(user: user),
//         SizeConst.addHorizontalSpace(context, 0.02),
//         Text(
//           user.userName,
//         ),
//         const Spacer(),
//         IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
//         IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
//         IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
//       ]),
//     );
//   }

//   Widget userInputForm(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: 12,
//         vertical: SizeConst.customHeight(context, .008),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Container(
//             width: SizeConst.customWidth(context, .78),
//             height: SizeConst.customHeight(context, .06),
//             decoration: BoxDecoration(
//               color: Theme.of(context).primaryColorLight,
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Row(
//               children: [
//                 ChatIconButton(
//                   onPressed: () {},
//                   icon: Icons.emoji_emotions_outlined,
//                 ),
//                 Expanded(
//                     child: TextFormField(
//                   decoration: InputDecoration(
//                     hintText: 'Message',
//                     hintStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
//                           fontSize: 18,
//                           color: Colors.grey,
//                         ),
//                     border: InputBorder.none,
//                   ),
//                 )),
//                 ChatIconButton(
//                   onPressed: () {},
//                   icon: Icons.attach_file,
//                 ),
//                 SizeConst.addHorizontalSpace(context, .001),
//                 ChatIconButton(
//                   onPressed: () {},
//                   icon: Icons.camera_alt_outlined,
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             height: SizeConst.customHeight(context, .06),
//             width: SizeConst.customWidth(context, .14),
//             decoration: const BoxDecoration(
//               shape: BoxShape.circle,
//               color: AppColorsLight.appBarColor,
//             ),
//             child: IconButton(
//                 onPressed: () {},
//                 icon: const Icon(
//                   Icons.mic,
//                   color: Colors.white,
//                 )),
//           )
//         ],
//       ),
//     );
//   }
// }

// class ChatIconButton extends StatelessWidget {
//   const ChatIconButton(
//       {super.key, required this.onPressed, required this.icon});

//   final void Function()? onPressed;
//   final IconData icon;

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       onPressed: onPressed,
//       icon: Icon(
//         icon,
//         color: Colors.grey,
//       ),
//     );
//   }
// }

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/widgets/loader.dart';

import 'package:whatsapp_clone/constants/app_colors.dart';
import 'package:whatsapp_clone/views/auth/controller/auth_controller.dart';

import '../../../utils/size/size_const.dart';
import '../widgets/user_chat.dart';

class ChatScreen extends ConsumerWidget {
  static const routeName = '/chat';
  const ChatScreen({
    Key? key,
    required this.name,
    required this.uid,
  }) : super(key: key);

  // final User user;
  final String name;
  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: chatAppBar(context, ref),
        body: Column(
          children: [
            const Expanded(child: UserChat()),
            userInputForm(context),
          ],
        ));
  }

  PreferredSizeWidget hatAppBar(BuildContext context) {
    return AppBar(
      title: Row(children: [
        // UserProfilePics(user: user),
        SizeConst.addHorizontalSpace(context, 0.02),
        Text(
          name,
        ),
        const Spacer(),
        IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
      ]),
    );
  }

  PreferredSizeWidget chatAppBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: StreamBuilder(
        stream: ref.read(authControllerProvider).getUserSnapshot(uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }

          return Column(children: [
            // UserProfilePics(user: user),
            // SizeConst.addHorizontalSpace(context, 0.02),
            Text(
              name,
            ),
            Text(
              snapshot.data!.isOnline ? 'Online' : 'Offline',
              style: const TextStyle(color: Colors.white),
            ),
          ]);
        },
      ),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
      ],
    );
  }

  Widget userInputForm(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: SizeConst.customHeight(context, .008),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: SizeConst.customWidth(context, .78),
            height: SizeConst.customHeight(context, .06),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                ChatIconButton(
                  onPressed: () {},
                  icon: Icons.emoji_emotions_outlined,
                ),
                Expanded(
                    child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Message',
                    hintStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                    border: InputBorder.none,
                  ),
                )),
                ChatIconButton(
                  onPressed: () {},
                  icon: Icons.attach_file,
                ),
                SizeConst.addHorizontalSpace(context, .001),
                ChatIconButton(
                  onPressed: () {},
                  icon: Icons.camera_alt_outlined,
                ),
              ],
            ),
          ),
          Container(
            height: SizeConst.customHeight(context, .06),
            width: SizeConst.customWidth(context, .14),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColorsLight.appBarColor,
            ),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.mic,
                  color: Colors.white,
                )),
          )
        ],
      ),
    );
  }
}

class ChatIconButton extends StatelessWidget {
  const ChatIconButton(
      {super.key, required this.onPressed, required this.icon});

  final void Function()? onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: Colors.grey,
      ),
    );
  }
}
