import 'dart:developer';

import '../examples/double/counter.dart';

void main(List<String> args) {
  Counter counter = Counter();
  final output = counter.presenter("42");
  log(output, name: 'OUTPUT - bin - main');
}
