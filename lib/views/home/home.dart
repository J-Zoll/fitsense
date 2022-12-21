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
        title: Text("Patronus"),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text("Profil"),
            ),
            ListTile(
              leading: Icon(Icons.contact_page),
              title: Text("Notfallkontakte"),
            )
          ],
        ),
      ),
    );
  }
}
