import 'package:fitsense/models/contact_repository.dart';
import 'package:fitsense/models/contact.dart';
import 'package:fitsense/models/user.dart';

import 'package:flutter_sms/flutter_sms.dart';

class AlarmService {
  static void sendAlarm() async {
    User user = await User.load();
    String message = _getAlarmMessage(user);

    List<Contact> contacts = await ContactRepository.load();
    List<String> recipients = contacts.map((e) => e.phone).toList();

    _sendSMS(message, recipients);
  }

  static String _getAlarmMessage(User user) {
    String message = "Ich bin gestürzt, bitte helfen Sie mir!\n\n";
    message = message + "Meine Notfallinformationen sind:\n";
    message = message + "Name: ${user.firstName} ${user.lastName}\n";
    message = message + "Geburtstag: ${user.birthday.day.toString().padLeft(2, "0")}.${user.birthday.month.toString().padLeft(2, "0")}.${user.birthday.year.toString()}\n";
    message = message + "Blutgruppe: ${user.bloodGroup.name}\n";
    message = message + "Ich habe folgende Allergien:\n";
    for (String allergy in user.allergies) {
      message = message + "${allergy}\n";
    }
    message = message + "Ich habe folgende Erkrankungen:\n";
    for (String disease in user.diseases) {
      message = message + "${disease}\n";
    }
    message = message + "Ich nehme die folgenden Medikamente:\n";
    for (String drug in user.drugs) {
      message = message + "${drug}\n";
    }
    return message;
  }

  static void _sendSMS(String message, List<String> recipients) async {
    String result = await sendSMS(message: message, recipients: recipients, sendDirect: true)
        .catchError((onError) {
      print(onError);
    });
    print(result);
  }
}