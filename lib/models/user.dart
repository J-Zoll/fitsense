import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'blood_group.dart';

class User {
  String firstName;
  String lastName;
  BloodGroup bloodGroup;
  List<String> allergies;

  User(
      this.firstName,
      this.lastName,
      this.bloodGroup,
      this.allergies,
    );

  String toJson() {
    return json.encode(
      {
        "firstName": firstName,
        "lastName": lastName,
        "bloodGroup": bloodGroup.name,
        "allergies": allergies,
      }
    );
  }

  static fromJson(String userJson) {
    var user = json.decode(userJson);
    String firstName = user["firstName"];
    String lastName = user["lastName"];
    BloodGroup bloodGroup = BloodGroup.fromName(user["bloodGroup"])!;
    List<String> allergies = (user["allergies"] as List).map((e) => e as String).toList();

    return User(firstName, lastName, bloodGroup, allergies);
  }

  Future<void> save() async {
    try {
      Directory dir = await getApplicationDocumentsDirectory();
      File userFile = File('${dir.path}/user.json');
      String userJson = toJson();
      await userFile.writeAsString(userJson);
    } on Exception catch (e) {
      print(e);
    }
  }

  static Future<User> load() async {
    try {
      Directory dir = await getApplicationDocumentsDirectory();
      File userFile = File('${dir.path}/user.json');
      String userJson = await userFile.readAsString(encoding: utf8);
      return User.fromJson(userJson);
    } on Exception catch (e) {
      print(e);
      throw(e);
    }
  }
}