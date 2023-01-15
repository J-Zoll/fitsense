import 'dart:ui';

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

  static const TextStyle _h1 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 28,
  );

  static const TextStyle _subheader = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle _h3 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle _data = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w300,
  );

  static const _dataPadding = EdgeInsets.only(bottom: 16);

  void _loadProfile() {
    User.load().then((User? user) => setState(() => _user = user));
  }

  Widget _showProfile() {
    return Padding(
      padding: EdgeInsets.all(24),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 56),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_user!.firstName, style: _h1),
                Text(_user!.lastName, style: _h1,),
                Text("${_user!.birthday.day.toString().padLeft(2, "0")}.${_user!.birthday.month.toString().padLeft(2, "0")}.${_user!.birthday.year}", style: _subheader,),
              ],
            ),
          ),
          Padding(
            padding: _dataPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Text("Blutgruppe", style: _h3,),
                Text(_user!.bloodGroup.name, style: _data,),
              ],
            ),
          ),
          Padding(
            padding: _dataPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Text("Allergien", style: _h3,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _user!.allergies.map((e) => Text("- ${e}", style: _data,)).toList(),
                ),
              ],
            ),
          ),
          Padding(
            padding: _dataPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Text("Krankheiten", style: _h3,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _user!.diseases.map((e) => Text("- ${e}", style: _data,)).toList(),
                ),
              ],
            ),
          ),
          Padding(
            padding: _dataPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Text("Medikamente", style: _h3,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _user!.drugs.map((e) => Text("- ${e}", style: _data,)).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
      body: _user != null ? _showProfile() : Center(
        child: Text("Du hast noch kein Profil angelegt"),
      ),
    );
  }
}
