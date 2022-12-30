import 'dart:convert';

import 'package:fitsense/views/profile/user_form.dart';
import 'package:flutter/material.dart';
import '../../models/user.dart';

class ProfileEditView extends StatefulWidget {
  const ProfileEditView({Key? key}) : super(key: key);

  @override
  State<ProfileEditView> createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {
  User? _user;
  void Function()? _onSubmit;

  void _submit() {
    _user?.save();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil bearbeiten"),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _onSubmit,
          )
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: UserForm(
          onChanged: (User? user) => setState(() {
              _user = user;

              if (_user != null) {
                _onSubmit = _submit;
              } else {
                _onSubmit = null;
              }
          })
          ),
        ),
    );
  }
}
