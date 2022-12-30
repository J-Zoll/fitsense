import 'package:fitsense/models/blood_group.dart';
import 'package:fitsense/views/profile/list_selector.dart';
import 'package:fitsense/widgets/text_list_form_field.dart';
import 'package:fitsense/widgets/text_select_form_field.dart';
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
  BloodGroup? _bloodGroup;
  List<String>? _allergies = [];

  final _fnController = TextEditingController();
  final _lnController = TextEditingController();
  final _bgController = TextEditingController();
  final _alController = TextEditingController();

  void _handleChanged() {
    if (widget.onChanged != null) {
      User? user;
      if (_formKey.currentState != null && _formKey.currentState!.validate()) {
        user = User(_firstName!, _lastName!, _bloodGroup!, _allergies!);
      }
      widget.onChanged!(user);
    }
  }

  @override
  void initState() {
    super.initState();

    User.load().then((User user) => setState(() {
          _firstName = user.firstName;
          _lastName = user.lastName;
          _bloodGroup = user.bloodGroup;
          _allergies = user.allergies;

          _handleChanged();
        }));
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
              controller: _fnController,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Dieses Feld darf nicht leer sein";
                }
                return null;
              },
              onChanged: (String firstName) => setState(() {
                _firstName = firstName.isEmpty ? null : firstName;
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
              controller: _lnController,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Dieses Feld darf nicht leer sein";
                }
                return null;
              },
              onChanged: (String lastName) => setState(() {
                _lastName = lastName.isEmpty ? null : lastName;
                _handleChanged();
              }),
              decoration: const InputDecoration(
                labelText: "Nachname",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextSelectFormField(
              labelText: "Blutgruppe",
              fetchInitValue: () => User.load().then((User user) => user.bloodGroup.name),
              options: BloodGroup.values.map((bg) => bg.name).toList(),
              onChanged: (String bgName) => setState(() => _bloodGroup = BloodGroup.fromName(bgName)),
            )
          ),
          TextListFormField(
            labelText: "Allergien",
            fetchInitValue: () => User.load().then((User user) => user.allergies),
            onChanged: (List<String> allergies) => setState(() {
              _allergies = allergies;
              _handleChanged();
            }),
          )
        ],
      ),
    );
  }
}
