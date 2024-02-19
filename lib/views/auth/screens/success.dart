import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  static const routeName = '/success';
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Success Screen',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
