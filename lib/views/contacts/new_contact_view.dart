import 'package:fitsense/models/contact_repository.dart';
import 'package:flutter/material.dart';

import '../../models/contact.dart';

class NewContactView extends StatefulWidget {
  NewContactView({Key? key}) : super(key: key);

  @override
  State<NewContactView> createState() => _NewContactViewState();
}

class _NewContactViewState extends State<NewContactView> {
  final _nameFieldController = TextEditingController();
  final _phoneFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _formIsValid = false;

  void _handleSubmit() {
    String name = _nameFieldController.text;
    String phone = _phoneFieldController.text;
    Contact newContact = Contact(name, phone);
    ContactRepository.save(newContact).then((_) => Navigator.of(context).pop());
  }

  void _handleChanged() {
    setState(() {
      _formIsValid = _formKey.currentState!.validate();
    });
  }

  String? _validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return "Dieses Feld darf nicht leer sein.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Neuer Notfallkontakt"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
              onPressed: _formIsValid ? _handleSubmit : null,
              icon: const Icon(Icons.check),
          )
        ],
      ),
      body: Form(
          key: _formKey,
          onChanged: _handleChanged,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: TextFormField(
                    validator: _validateNotEmpty,
                    controller: _nameFieldController,
                    decoration: const InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.phone),
                title: TextFormField(
                  validator: _validateNotEmpty,
                  controller: _phoneFieldController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Telefonnummer",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}
