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

  @override
  void initState() {
    User.load().then((User user) => setState(() => _user = user));

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
                .then((value) => setState(() {})),

              icon: Icon(Icons.edit)
          )
        ],
      ),
      body: Text(_user?.toJson() ?? "null"),
    );
  }
}
