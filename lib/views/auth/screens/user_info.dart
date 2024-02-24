import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/utils/utils.dart';
import 'package:whatsapp_clone/views/auth/controller/auth_controller.dart';

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

class UserInfoDetails extends ConsumerStatefulWidget {
  const UserInfoDetails({
    super.key,
  });

  @override
  ConsumerState<UserInfoDetails> createState() => _UserInfoDetailsState();
}

class _UserInfoDetailsState extends ConsumerState<UserInfoDetails> {
  TextEditingController nameController = TextEditingController();
  File? image;

  void selectUserProfile() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void saveUserData() {
    final name = nameController.text.trim();

    if (name.isNotEmpty) {
      ref.read(authControllerProvider).saveUserDataToFirebase(
          context: context, name: name, profileImage: image);
    } else {
      showSnackBar(context: context, error: 'Fill in your details correctly');
    }
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
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
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
                  onPressed: saveUserData,
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
