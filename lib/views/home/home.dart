import 'package:fitsense/services/alarm_service.dart';
import 'package:fitsense/views/contacts/contacts.dart';
import 'package:fitsense/views/fall_detection/fall_detection_view.dart';
import 'package:fitsense/views/home/ESenseConnection.dart';
import 'package:fitsense/views/settings/settings.dart';
import 'package:fitsense/widgets/big_icon_button.dart';
import 'package:fitsense/views/profile/profile.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Patronus"),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Settings())),
              icon: const Icon(Icons.settings)
          ),
        ],
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
            ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FallDetectionView())
                ),
                child: Text("Fallerkennung"),
            ),
            Expanded(child: Container()),
            ESenseConnection(),
          ],
        ),
      ),
    );
  }
}
