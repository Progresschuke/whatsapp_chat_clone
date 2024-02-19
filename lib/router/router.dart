import 'package:flutter/material.dart';

import '../views/auth/screens/login.dart';
import '../views/auth/screens/otp.dart';
import '../views/auth/screens/success.dart';
import '../views/error/error.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );

    case OtpScreen.routeName:
      final verificationId = settings.arguments as String?;
      return MaterialPageRoute(
        builder: (context) => OtpScreen(verificationId: verificationId),
      );

    // case ChatScreen.routeName:
    // final user = settings.arguments as User;
    // return MaterialPageRoute(
    //   builder: (context) => ChatScreen(user: user),
    // );

    case SuccessScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SuccessScreen(),
      );

    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: 'This page does not exist'),
        ),
      );
  }
}
