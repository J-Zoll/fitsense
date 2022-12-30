import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class User {
  String firstName;
  String lastName;

  User(
      this.firstName,
      this.lastName,
    );

  String toJson() {
    return json.encode(
      {
        "firstName": firstName,
        "lastName": lastName,
      }
    );
  }

  static fromJson(String userJson) {
    var user = json.decode(userJson);
    String firstName = user["firstName"];
    String lastName = user["lastName"];

    return User(firstName, lastName);
  }

  Future<void> save() async {
    Directory dir = await getApplicationDocumentsDirectory();
    File userFile = File('${dir.path}/user.json');
    String userJson = toJson();
    await userFile.writeAsString(userJson);
  }

  static Future<User> load() async {
    Directory dir = await getApplicationDocumentsDirectory();
    File userFile = File('${dir.path}/user.json');
    String userJson = await userFile.readAsString(encoding: utf8);
    return User.fromJson(userJson);
  }
}