import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar({required BuildContext context, required String error}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
}

String getContactInitials(String displayName) {
  List<String> names = displayName.split(" ");
  String initials = "";

  // Iterate through the first 2 names or until the end of the list
  for (int i = 0; i < names.length && i < 2; i++) {
    if (names[i].isNotEmpty) {
      initials += names[i][0].toUpperCase();
    }
  }

  return initials;
}

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;
  try {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      image = File(pickedImage.path);
      debugPrint('============================================');
      print(image.path);
    }
  } catch (e) {
    if (context.mounted) {
      showSnackBar(context: context, error: e.toString());
    }
  }
  return image;
}
