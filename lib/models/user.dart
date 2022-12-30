import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'blood_group.dart';

class User {
  String firstName;
  String lastName;
  BloodGroup bloodGroup;

  User(
      this.firstName,
      this.lastName,
      this.bloodGroup,
    );

  String toJson() {
    return json.encode(
      {
        "firstName": firstName,
        "lastName": lastName,
        "bloodGroup": bloodGroup.name,
      }
    );
  }

  static fromJson(String userJson) {
    var user = json.decode(userJson);
    String firstName = user["firstName"];
    String lastName = user["lastName"];
    BloodGroup bloodGroup = BloodGroup.fromName(user["bloodGroup"])!;

    return User(firstName, lastName, bloodGroup);
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