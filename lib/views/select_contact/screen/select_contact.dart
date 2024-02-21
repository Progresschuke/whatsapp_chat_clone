import 'package:flutter/material.dart';

class SelectContactScreen extends StatelessWidget {
  static const routeName = '/select_contact';
  const SelectContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Contact'), actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
      ]),
      body: const Center(
        child: Text(
          'Select Contact Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
