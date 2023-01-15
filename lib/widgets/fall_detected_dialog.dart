import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:fitsense/services/alarm_service.dart';
import 'package:flutter/material.dart';

class FallDetectedDialog extends StatefulWidget {
  const FallDetectedDialog({Key? key}) : super(key: key);

  @override
  State<FallDetectedDialog> createState() => _FallDetectedDialogState();
}

class _FallDetectedDialogState extends State<FallDetectedDialog> {
  int _countdown = 15;
  Timer? _timer;
  bool _alarmSent = false;

  void _beep() async {
    await AudioPlayer().play(AssetSource("beep-06.wav"), volume: 1);
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_countdown == 0) {
        setState(() {
          timer.cancel();
          _sendAlarm();
        });
      } else {
        setState(() {
          _beep();
          _countdown--;
        });
      }
    });
  }

  void _sendAlarm() {
    _timer?.cancel();
    AlarmService.sendAlarm();
    setState(() {
      _alarmSent = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Ein Sturz wurde erkannt!"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
              "Nach Ablauf des Countdowns wird automatisch Hilfe gerufen."),
          !_alarmSent
              ? Padding(
                  padding: const EdgeInsets.only(top: 32.0, bottom: 32.0),
                  child: Text(
                    "$_countdown",
                    style: const TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : const Padding(
                  padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
                  child: Text(
                    "Notruf wurde gesendet",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                    textAlign: TextAlign.center,
                  ),
                ),
          !_alarmSent ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                      child: Text("Abbrechen"),
                    )),
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ElevatedButton(
                    onPressed: _sendAlarm,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                      child: Text("Notruf senden"),
                    )),
              )),
            ],
          ) : Container()
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
