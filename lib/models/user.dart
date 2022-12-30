import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'blood_group.dart';

class User {
  String firstName;
  String lastName;
  BloodGroup bloodGroup;
  List<String> allergies;
  List<String> diseases;
  List<String> drugs;

  User(this.firstName, this.lastName, this.bloodGroup, this.allergies,
      this.diseases, this.drugs);

  String toJson() {
    return json.encode({
      "firstName": firstName,
      "lastName": lastName,
      "bloodGroup": bloodGroup.name,
      "allergies": allergies,
      "diseases": diseases,
      "drugs": drugs,
    });
  }

  static fromJson(String userJson) {
    var user = json.decode(userJson);

    String firstName = user["firstName"];
    String lastName = user["lastName"];
    BloodGroup bloodGroup = BloodGroup.fromName(user["bloodGroup"])!;
    List<String> allergies =
        (user["allergies"] as List).map((e) => e as String).toList();
    List<String> diseases =
        (user["diseases"] as List).map((e) => e as String).toList();
    List<String> drugs =
        (user["drugs"] as List).map((e) => e as String).toList();

    return User(firstName, lastName, bloodGroup, allergies, diseases, drugs);
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
