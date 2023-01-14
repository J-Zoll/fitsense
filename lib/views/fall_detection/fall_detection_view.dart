import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:fitsense/services/fall_detection_service.dart';
import 'package:flutter/material.dart';
import 'package:motion_sensors/motion_sensors.dart';

class FallDetectionView extends StatefulWidget {
  const FallDetectionView({Key? key}) : super(key: key);

  @override
  State<FallDetectionView> createState() => _FallDetectionViewState();
}

class _FallDetectionViewState extends State<FallDetectionView> {
  FallDetectionService? _fallDetectionService;

  void _beep() async {
    await AudioPlayer().play(AssetSource("beep-06.wav"), volume: 1);
  }

  @override
  void initState() {
    _fallDetectionService = FallDetectionService(() => _beep());
    _fallDetectionService!.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fallerkennung"),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: MotionSensor.motionStream,
          builder: (context, snapshot) {
            final pitch = snapshot.data!.pitch;
            final roll = snapshot.data!.roll;
            
            final x_coef = cos(pitch) * sin(roll);
            final y_coef = sin(pitch);
            final z_coef = cos(pitch) * cos(roll);
            
            return Column(
              children: [
                Text(x_coef.toStringAsFixed(3)),
                Text(y_coef.toStringAsFixed(3)),
                Text(z_coef.toStringAsFixed(3)),
              ],
            );
          }
        ),
    );
  }

  @override
  void dispose() {
    _fallDetectionService!.cancel();
    super.dispose();
  }
}
