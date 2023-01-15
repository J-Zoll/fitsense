import 'dart:io';

import 'package:fitsense/services/alarm_service.dart';
import 'package:fitsense/views/contacts/contacts.dart';
import 'package:fitsense/views/home/ESenseConnection.dart';
import 'package:fitsense/widgets/big_icon_button.dart';
import 'package:fitsense/views/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  _askForPermissions() async {
    while (!await Permission.sms.isGranted) {
      await Permission.sms.request();
    }
    sleep(Duration(seconds: 1));
    while (!await Permission.location.isGranted) {
      await Permission.location.request();
    }
    sleep(Duration(seconds: 1));
    while (!await Permission.bluetooth.isGranted) {
      await Permission.bluetooth.request();
    }
  }

  @override
  void initState() {
    super.initState();
    _askForPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Patronus"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => AlarmService.sendAlarm(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 40, 30, 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.emergency_outlined,
                      size: 70,
                    ),
                    Text(
                        "Hilfe rufen",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BigIconButton(
                    iconData: Icons.account_circle,
                    text: "Mein Profil",
                    onPressed: () => Navigator
                        .of(context)
                        .push(MaterialPageRoute(
                          builder: (context) => const Profile())
                        ),
                  ),
                  BigIconButton(
                    iconData: Icons.contact_page,
                    text: "Notfallkontakte",
                    onPressed: () => Navigator
                        .of(context)
                        .push(MaterialPageRoute(
                          builder: (context) => const Contacts())
                        ),
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
            ESenseConnection(),
          ],
        ),
      ),
    );
  }
}
