import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double? x;
  double? y;
  double? z;
  double? pitch;
  double? roll;
  double? yaw;

  @override
  Widget build(BuildContext context) {
    Stream<GyroscopeEvent> gyroscopeStream = SensorsPlatform.instance.gyroscopeEvents;
    Stream<UserAccelerometerEvent> accelerometerStream = SensorsPlatform.instance.userAccelerometerEvents;

    gyroscopeStream.listen((event) {
      setState(() {
        pitch = event.x;
        roll = event.y;
        yaw = event.z;
      });
    });

    accelerometerStream.listen((event) {
      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            pitch != null ? "pitch: $pitch" : "pitch: no data",
            roll != null ? "roll: $roll" : "roll: no data",
            yaw != null ? "yaw: $yaw" : "yaw: no data",
            x != null ? "x: $x" : "x: no data",
            y != null ? "y: $y" : "y: no data",
            z != null ? "z: $z" : "z: no data",
          ].map((String str) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(str),
          )).toList(),
        ),
      ),
    );
  }
}
