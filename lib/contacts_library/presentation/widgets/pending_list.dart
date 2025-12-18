import 'package:flick/contacts_library/domain/contact.dart';
import 'package:flutter/material.dart';

class PendingList extends StatelessWidget {
  final List<Contact> contacts;
  const PendingList({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => Text(contacts[index].username),
    );
  }
}
