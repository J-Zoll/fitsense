import 'package:fitsense/models/blood_group.dart';
import 'package:fitsense/views/profile/list_selector.dart';
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

          _fnController.text = user.firstName;
          _lnController.text = user.lastName;
          _bgController.text = user.bloodGroup.name;
          _alController.text = user.allergies
              .fold("", (prefix, element) => prefix + "- ${element}\n").trim();

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
            child: TextFormField(
              readOnly: true,
              controller: _bgController,
              onTap: () => showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Blutgruppe"),
                    content: Column(
                      children: BloodGroup.values
                          .map((bg) => ListTile(
                                title: Text(bg.name),
                                onTap: () => setState(() {
                                  _bloodGroup = bg;
                                  _bgController.text = bg.name;
                                  _handleChanged();
                                  Navigator.of(context).pop();
                                }),
                              ))
                          .toList(),
                    ),
                  );
                },
              ),
              decoration: const InputDecoration(
                labelText: "Blutgruppe",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          TextFormField(
            controller: _alController,
            maxLines: null,
            readOnly: true,
            decoration: const InputDecoration(
                labelText: "Allergien", border: OutlineInputBorder()),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ListSelector(
                    title: "Allergien",
                    initValue: _allergies,
                    onFinished: (allergies) {
                      setState(() {
                        _allergies = allergies;
                        _alController.text = _allergies!.fold(
                            "", (prefix, element) => prefix + "- ${element}\n").trim();
                      });
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
