import 'package:fitsense/views/profile/profile_edit_view.dart';
import 'package:flutter/material.dart';

import '../../models/user.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? _user;

  void _loadProfile() {
    User.load().then((User user) => setState(() => _user = user));
  }

  @override
  void initState() {
    _loadProfile();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mein Profil"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ProfileEditView()))
                .then((value) => _loadProfile()),

              icon: Icon(Icons.edit)
          )
        ],
      ),
      body: Text(_user?.toJson() ?? "null"),
    );
  }
}
