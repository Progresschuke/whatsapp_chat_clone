import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import '../../../utils/utils.dart';

class SelectContactCard extends StatelessWidget {
  const SelectContactCard({
    super.key,
    required this.contact,
  });

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(contact.displayName),
      leading: contact.photo == null
          ? CircleAvatar(
              backgroundImage: null,
              child: Text(getContactInitials(contact.displayName)),
            )
          : CircleAvatar(
              backgroundImage: MemoryImage(contact.photo!),
            ),
    );
  }
}
