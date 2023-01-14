import 'package:rxdart/rxdart.dart';
import 'package:esense_flutter/esense.dart';
import 'vector_utils.dart';


class ESenseFallDetection {
  final accelerationThreshold = 2800.0;
  List<void Function()> listeners;

  ESenseFallDetection(this.listeners) {
    ESenseManager()
        .sensorEvents
        .map((event) => event.accel!) // only take the acceleration values
        .bufferCount(10, 1) // smooth the values with a moving average
        .map((vs) => transpose(vs))
        .map((vs) => average(vs))
        .map((vec) => magnitude(vec)) // calculate the magnitude
        .bufferCount(2,
            1) // remove gravitation by taking the difference of two consecutive values
        .map((pair) => (pair[0] - pair[1]).abs())
        .map((accTotal) => accTotal > accelerationThreshold) // if total acceleration exceeds a threshold inform all listeners
        .listen(_handleFall);
  }

  void _handleFall(bool isFall) {
    if (isFall) {
      for (final func in listeners) {
        func();
      }
    }
  }
}
