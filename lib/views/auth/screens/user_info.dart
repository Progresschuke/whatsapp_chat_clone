import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapp_clone/utils/utils.dart';

import '../../../constants/app_images.dart';
import '../../../utils/size/size_const.dart';

class UserInfoScreen extends StatelessWidget {
  static const routeName = '/userInfo';
  const UserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: UserInfoDetails(),
    );
  }
}

class UserInfoDetails extends StatefulWidget {
  const UserInfoDetails({
    super.key,
  });

  @override
  State<UserInfoDetails> createState() => _UserInfoDetailsState();
}

class _UserInfoDetailsState extends State<UserInfoDetails> {
  TextEditingController nameController = TextEditingController();
  File? image;

  void selectUserProfile() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizeConst.addVerticalSpace(context, 0.05),
        Stack(
          children: [
            image != null
                ? CircleAvatar(
                    backgroundImage: FileImage(image!),
                    radius: 60,
                  )
                : const CircleAvatar(
                    backgroundImage: AssetImage(AppImages.defaultProfile),
                    radius: 60,
                  ),
            Positioned(
                bottom: 0,
                right: -4,
                child: IconButton(
                    onPressed: selectUserProfile,
                    icon: const Icon(
                      Icons.add_a_photo,
                      size: 35,
                    )))
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      hintText: 'Enter your name',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.grey, fontSize: 20)),
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.done,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
