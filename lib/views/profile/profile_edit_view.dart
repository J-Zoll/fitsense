import 'package:flutter/material.dart';
import '../../models/user.dart';

class ProfileEditView extends StatefulWidget {
  const ProfileEditView({Key? key}) : super(key: key);

  @override
  State<ProfileEditView> createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {

  final _formKey = GlobalKey<FormState>();
  final _user = User("", "");

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
            onPressed: () {
              _formKey.currentState?.save();
              _user.save();
              Navigator.of(context).pop();
            },
          )
        ],
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: User.load(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.done) {
              User initialUser = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextFormField(
                          initialValue: initialUser.firstName,
                          validator: (String? value) {
                            if(value == null || value.isEmpty) {
                              return "Dieses Feld darf nicht leer sein";
                            }
                            return null;
                          },
                          onSaved: (String? firstName) => setState(() => _user.firstName = firstName!),
                          decoration: const InputDecoration(
                            labelText: "Vorname",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextFormField(
                          initialValue: initialUser.lastName,
                          validator: (String? value) {
                            if(value == null || value.isEmpty) {
                              return "Dieses Feld darf nicht leer sein";
                            }
                            return null;
                          },
                          onSaved: (String? lastName) => setState(() => _user.lastName = lastName!),
                          decoration: const InputDecoration(
                            labelText: "Vorname",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
      )
    );
  }
}
