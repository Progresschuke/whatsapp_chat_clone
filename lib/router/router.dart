import 'package:flutter/material.dart';
import 'package:whatsapp_clone/views/auth/screens/login.dart';
import 'package:whatsapp_clone/views/auth/screens/otp.dart';

import '../views/error/error.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );

    case OtpScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const OtpScreen(),
      );

    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: 'This page does not exist'),
        ),
      );
  }
}
