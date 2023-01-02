import 'package:fitsense/models/contact.dart';
import 'package:fitsense/models/contact_repository.dart';
import 'package:fitsense/views/contacts/new_contact_view.dart';
import 'package:flutter/material.dart';

class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List<Contact>? _contactList = [];

  void _handleBack() {
    ContactRepository.saveList(_contactList ?? [])
        .then((_) => Navigator.of(context).pop());
  }

  void _loadContacts() {
    ContactRepository.load().then((List<Contact> contactList) =>
        setState(() => _contactList = contactList));
  }

  @override
  void initState() {
    _loadContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notfallkontakte"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => _handleBack(), icon: const Icon(Icons.arrow_back)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => NewContactView()))
            .then((_) => _loadContacts()),
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: _contactList
            ?.map((contact) => Card(
          child: ListTile(
            title: Text(contact.name),
            subtitle: Text(contact.phone),
            trailing: IconButton(
              onPressed: () => ContactRepository.delete(contact)
                  .then((_) => _loadContacts()),
              icon: const Icon(Icons.delete),
            ),
          ),
        ))
            .toList() ??
            [],
      ),
    );
  }
}
