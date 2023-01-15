import 'package:fitsense/models/blood_group.dart';
import 'package:fitsense/widgets/better_text_form_field.dart';
import 'package:fitsense/widgets/date_form_field.dart';
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
  DateTime? _birthday;
  BloodGroup? _bloodGroup;
  List<String> _allergies = [];
  List<String> _diseases = [];
  List<String> _drugs = [];

  void _handleChanged() {
    if (widget.onChanged != null) {
      User? user;
      if (_formKey.currentState != null && _formKey.currentState!.validate()) {
        user = User(_firstName!, _lastName!, _birthday!, _bloodGroup!,
            _allergies, _diseases, _drugs);
      }
      widget.onChanged!(user);
    }
  }

  String? _nonEmptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Dieses Feld darf nicht leer sein";
    }
    return null;
  }

  @override
  void initState() {
    super.initState();

    User.load().then((User? user) => setState(() {
          if (user != null) {
            _firstName = user.firstName;
            _lastName = user.lastName;
            _birthday = user.birthday;
            _bloodGroup = user.bloodGroup;
            _allergies = user.allergies;
            _diseases = user.diseases;
            _drugs = user.drugs;
            _handleChanged();
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: BetterTextFormField(
                labelText: "Vorname",
                validator: _nonEmptyValidator,
                fetchInitValue: () =>
                    User.load().then((User? user) => user?.firstName),
                onChanged: (String firstName) => setState(() {
                  _firstName = firstName;
                  _handleChanged();
                }),
              )),
          Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: BetterTextFormField(
                labelText: "Nachname",
                validator: _nonEmptyValidator,
                fetchInitValue: () =>
                    User.load().then((User? user) => user?.lastName),
                onChanged: (String lastName) => setState(() {
                  _lastName = lastName;
                  _handleChanged();
                }),
              )),
          Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: DateFormField(
              labelText: "Geburtstag",
              onChanged: (DateTime birthday) => setState(() {
                _birthday = birthday;
                _handleChanged();
              }),
              fetchInitValue: () =>
                  User.load().then((User? user) => user?.birthday),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextSelectFormField(
                labelText: "Blutgruppe",
                fetchInitValue: () =>
                    User.load().then((User? user) => user?.bloodGroup.name),
                options: BloodGroup.values.map((bg) => bg.name).toList(),
                onChanged: (String bgName) => setState(() {
                  _bloodGroup = BloodGroup.fromName(bgName);
                  _handleChanged();
                }),
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextListFormField(
              labelText: "Allergien",
              fetchInitValue: () =>
                  User.load().then((User? user) => user?.allergies),
              onChanged: (List<String> allergies) => setState(() {
                _allergies = allergies;
                _handleChanged();
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextListFormField(
              labelText: "Krankheiten",
              fetchInitValue: () =>
                  User.load().then((User? user) => user?.diseases),
              onChanged: (List<String> diseases) => setState(() {
                _diseases = diseases;
                _handleChanged();
              }),
            ),
          ),
          TextListFormField(
            labelText: "Medikamente",
            fetchInitValue: () => User.load().then((User? user) => user?.drugs),
            onChanged: (List<String> drugs) => setState(() {
              _drugs = drugs;
              _handleChanged();
            }),
          ),
        ],
      ),
    );
  }
}
