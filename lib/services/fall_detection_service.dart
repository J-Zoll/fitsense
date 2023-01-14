import 'dart:async';
import 'dart:math';

import 'package:motion_sensors/motion_sensors.dart';
import 'package:rxdart/rxdart.dart';

class FallDetectionService {
  static const THRESHOLD_A_TOTAL = 6;
  static const THRESHOLD_A_VERTICAL = 5;

  Function onFall;

  FallDetectionService(this.onFall);

  late StreamSubscription _motionStreamSubscription;

  bool _isFall(MotionEvent event) {
    double a_total = _getATotal(event);
    double a_vertical = _getAVertical(event);

    return a_total > THRESHOLD_A_TOTAL && a_vertical > THRESHOLD_A_VERTICAL;
  }

  void _handleMotionEvent(MotionEvent event) {
    if (_isFall(event)) {
      print("fall");
      onFall();
    }
  }

  void start() {
    print("start");
    _motionStreamSubscription =
        MotionSensor.motionStream.listen((event) => _handleMotionEvent(event));
  }

  void pause() {
    print("pause");
    _motionStreamSubscription.pause();
  }

  void resume() {
    print("resume");
    _motionStreamSubscription.resume();
  }

  void cancel() {
    print("cancel");
    _motionStreamSubscription.cancel();
  }

  double _getATotal(MotionEvent event) {
    return sqrt(pow(event.x, 2) + pow(event.y, 2) + pow(event.z, 2));
  }

  double _getAVertical(MotionEvent event) {
    return event.x * cos(event.pitch) * sin(event.roll) +
        event.y * sin(event.pitch) +
        event.z * cos(event.pitch) * cos(event.roll);
  }
}

class MotionSensor {
  static Stream<MotionEvent> motionStream = motionSensors.userAccelerometer
      .zipWith(motionSensors.absoluteOrientation,
          (a, o) => MotionEvent.fromEvents(a, o));
}

class MotionEvent {
  MotionEvent(this.x, this.y, this.z, this.roll, this.pitch, this.yaw);

  static fromEvents(UserAccelerometerEvent a, AbsoluteOrientationEvent o) {
    return MotionEvent(a.x, a.y, a.z, o.roll, o.pitch, o.yaw);
  }

  final double x;
  final double y;
  final double z;
  final double pitch;
  final double roll;
  final double yaw;

  @override
  String toString() =>
      '[MotionEvent (x: $x, y: $y, z: $z, $roll, $pitch, $yaw)]';
}
