import 'dart:math';
import 'package:collection/collection.dart';


double magnitude(List<num> vec) {
  // |v| = sqrt(v1*v1 + v2*v2 + ...)
  return sqrt(vec.map((e) => pow(e, 2)).reduce((xs, x) => xs + x));
}

List<List<T>> transpose<T>(List<List<T>> matrix) {
  List<List<T>> transposed = [];

  for (int i = 0; i < matrix[0].length; i++) {
    List<T> row = [];
    for (int j = 0; j < matrix.length; j++) {
      row.add(matrix[j][i]);
    }
    transposed.add(row);
  }
  return transposed;
}

List<double> average(List<List<num>> matrix) {
  return matrix.map((vec) => vec.average).toList();
}