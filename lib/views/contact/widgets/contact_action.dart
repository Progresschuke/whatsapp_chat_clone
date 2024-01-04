import 'package:flutter/material.dart';

class ContactPageAction extends StatelessWidget {
  const ContactPageAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'WhatsApp Progxy',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
        ),
        const Spacer(),
        ActionButton(
          onPressed: () {},
          icon: Icons.camera_alt_outlined,
        ),
        ActionButton(
          onPressed: () {},
          icon: Icons.search,
        ),
        ActionButton(
          onPressed: () {},
          icon: Icons.more_vert_rounded,
        ),
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final void Function() onPressed;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onPressed, icon: Icon(icon));
  }
}
