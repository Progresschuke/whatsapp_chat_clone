import 'package:flutter/material.dart';

class OtpScreen extends StatelessWidget {
  static const routeName = '/otp';
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'OTP Screen',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
