import "package:flutter/material.dart";

import '../../models/user.dart';

class UserForm extends StatefulWidget {
  final Function(User?)? onChanged;
  const UserForm({Key? key, this.onChanged}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  String? _firstName;
  String? _lastName;

  void _handleChanged() {
    if(widget.onChanged != null) {
      User? user;
      if (_formKey.currentState != null && _formKey.currentState!.validate()) {
        user = User(_firstName!, _lastName!);
      }
      widget.onChanged!(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextFormField(
              validator: (String? value) {
                if(value == null || value.isEmpty) {
                  return "Dieses Feld darf nicht leer sein";
                }
                return null;
              },
              onChanged: (String firstName) => setState(() {
                _firstName=firstName.isEmpty ? null : firstName;
                _handleChanged();
              }),
              decoration: const InputDecoration(
                labelText: "Vorname",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextFormField(
              validator: (String? value) {
                if(value == null || value.isEmpty) {
                  return "Dieses Feld darf nicht leer sein";
                }
                return null;
              },
              onChanged: (String lastName) => setState(() {
                _lastName=lastName.isEmpty ? null : lastName;
                _handleChanged();
              }),
              decoration: const InputDecoration(
                labelText: "Nachname",
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
