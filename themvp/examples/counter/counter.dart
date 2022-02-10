import 'package:themvp/mvp.dart';

// class CounterModel extends IModel<String, int> {
//   @override
//   int model({required String params}) {
//     return int.parse(params) + 1;
//   }
// }

// * Use extends instead implements or with.
class Counter extends IPresenter<String, int, String, String> {
  @override
  int model({required String params}) {
    return int.parse(params) + 1;
  }

  @override
  String view({required int model}) {
    return model.toString();
  }
}

void main() {
  Counter counter = Counter();
  final output = counter.presenter("42");
  print("[OUTPUT]: $output");
}
