import 'package:themvp/mvp.dart';

import './counter.dart';

// * Use extends instead implements or with.
class DoubleMe extends IPresenter<int, int, int, int> {
  @override
  int model({required int params}) {
    return params * 2;
  }

  @override
  int view({required int model}) {
    return model;
  }
}

void main() {
  Counter counter = Counter();
  final output = counter.presenter("42");
  print("[OUTPUT]: $output");
}
