import 'package:audioplayers/audioplayers.dart';
import 'package:fitsense/services/fall_detection_service.dart';
import 'package:fitsense/widgets/fall_detected_dialog.dart';
import 'package:flutter/material.dart';
import 'package:esense_flutter/esense.dart';

class ESenseConnection extends StatefulWidget {
  const ESenseConnection({Key? key}) : super(key: key);

  @override
  State<ESenseConnection> createState() => _ESenseConnectionState();
}

class _ESenseConnectionState extends State<ESenseConnection> {
  final String _eSenseName = "myEarables";
  bool _openDialog = false;

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

  void _setupFallDetection() {
    ESenseFallDetection fallDetection =
        ESenseFallDetection([_handleFallDetected]);
    print("Fall detection is running..");
  }

  void _handleFallDetected() {
    if (!_openDialog) {
      _openDialog = true;
      showDialog(
        context: context,
        builder: (_) => FallDetectedDialog(),
        barrierDismissible: false,
      ).then((_) => _openDialog = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectionEvent>(
      stream: ESenseManager().connectionEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data!.type) {
            case ConnectionType.connected:
              _setupFallDetection();
              return const Padding(
                padding: EdgeInsets.only(bottom: 56.0),
                child: Center(child: Text("eSense verbunden")),
              );
            case ConnectionType.unknown:
              return ReconnectButton(
                onPressed: _connectToESense,
                child: const Text("Verbinung: Unbekannt"),
              );
            case ConnectionType.disconnected:
              return ReconnectButton(
                onPressed: _connectToESense,
                child: const Text("Verbinung: Getrennt"),
              );
            case ConnectionType.device_found:
              return const Padding(
                padding: EdgeInsets.only(bottom: 56.0),
                child: Center(child: Text("Verbinung: Gerät gefunden")),
              );
            case ConnectionType.device_not_found:
              return ReconnectButton(
                onPressed: _connectToESense,
                child: Text("Verbinung: Gerät nicht gefunden - $_eSenseName"),
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
