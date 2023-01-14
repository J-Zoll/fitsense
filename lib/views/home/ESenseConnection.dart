import 'package:flutter/material.dart';
import 'package:esense_flutter/esense.dart';

class ESenseConnection extends StatefulWidget {
  const ESenseConnection({Key? key}) : super(key: key);

  @override
  State<ESenseConnection> createState() => _ESenseConnectionState();
}

class _ESenseConnectionState extends State<ESenseConnection> {
  final String _eSenseName = "myEarables";
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _connectToESense();
  }

  Future<void> _connectToESense() async {
    await ESenseManager().disconnect();
    bool hasSuccessfulConneted = await ESenseManager().connect(_eSenseName);
    print("hasSuccessfulConneted: $hasSuccessfulConneted");
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectionEvent>(
      stream: ESenseManager().connectionEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data!.type) {
            case ConnectionType.connected:
              return Padding(
                padding: const EdgeInsets.only(bottom: 56.0),
                child: Center(child: Text("eSense verbunden")),
              );
            case ConnectionType.unknown:
              return ReconnectButton(
                child: const Text("Verbinung: Unbekannt"),
                onPressed: _connectToESense,
              );
            case ConnectionType.disconnected:
              return ReconnectButton(
                child: const Text("Verbinung: Getrennt"),
                onPressed: _connectToESense,
              );
            case ConnectionType.device_found:
              return Padding(
                padding: const EdgeInsets.only(bottom: 56.0),
                child: Center(child: Text("Verbinung: Gerät gefunden")),
              );
            case ConnectionType.device_not_found:
              return ReconnectButton(
                child: Text("Verbinung: Gerät nicht gefunden - $_eSenseName"),
                onPressed: _connectToESense,
              );
          }
        } else {
          return const Center(child: Text("Warte auf Verbindungsdaten..."));
        }
      },
    );
  }

  @override
  void dispose() {
    ESenseManager().disconnect();
    super.dispose();
  }
}

class ReconnectButton extends StatelessWidget {
  const ReconnectButton(
      {Key? key, required this.child, required this.onPressed})
      : super(key: key);

  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: child),
            ),
            ElevatedButton(
              onPressed: onPressed,
              child: const Text("eSense verbinden"),
            ),
          ]),
    );
  }
}
