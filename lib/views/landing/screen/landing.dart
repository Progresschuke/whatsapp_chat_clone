import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constants/app_colors.dart';
import 'package:whatsapp_clone/constants/app_images.dart';
import 'package:whatsapp_clone/utils/size/size_const.dart';
import 'package:whatsapp_clone/views/auth/screens/login.dart';

class LandingScreen extends StatelessWidget {
  static const routeName = '/landing';
  const LandingScreen({super.key});

  void navigateToAuth(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizeConst.addVerticalSpace(context, 0.1),
          const CustomText(
            text: 'Welcome to WhatsApp',
            fontSize: 42,
            fontWeight: FontWeight.w500,
          ),
          SizeConst.addVerticalSpace(context, 0.1),
          Image.asset(
            AppImages.landingPage,
            color: AppColorsLight.appBarColor,
            height: 340,
            width: 340,
          ),
          SizeConst.addVerticalSpace(context, 0.1),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: const CustomText(
              text:
                  'Read our Privacy Policy. Tap "Agree and continue" to accept the Terms of Service',
              color: Colors.grey,
            ),
          ),
          SizeConst.addVerticalSpace(context, 0.05),
          CustomButton(
            onPressed: () => navigateToAuth(context),
            text: 'AGREE AND CONTINUE',
          )
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final void Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: AppColorsLight.appBarColor,
          fixedSize: Size(SizeConst.customWidth(context, 0.7), 40),
          shape: const ContinuousRectangleBorder()),
      child: Text(text),
    );
  }
}

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w400,
    this.color,
  });

  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
          ),
    );
  }
}
