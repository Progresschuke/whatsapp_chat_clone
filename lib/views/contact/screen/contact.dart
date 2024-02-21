import 'package:flutter/material.dart';

import '../../select_contact/screen/select_contact.dart';
import '../widgets/contact_action.dart';
import '../widgets/contact_list.dart';

class ContactScreen extends StatelessWidget {
  static const routeName = '/contact';
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const ContactPageAction(),
          bottom: const TabBar(tabs: [
            Tab(
                child: Icon(
              Icons.groups_rounded,
              size: 30,
            )),
            Tab(child: TabText('Chats')),
            Tab(child: TabText('Updates')),
            Tab(child: TabText('Calls')),
          ]),
        ),
        body: TabBarView(children: [
          Center(
            child: Text(
              'My Community',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const ContactList(),
          Center(
            child: Text(
              'My Updates',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Center(
            child: Text(
              'My Calls',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, SelectContactScreen.routeName);
          },
          child: const Icon(Icons.message_rounded),
        ),
      ),
    );
  }
}

class TabText extends StatelessWidget {
  const TabText(this.text, {super.key});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16),
    );
  }
}
