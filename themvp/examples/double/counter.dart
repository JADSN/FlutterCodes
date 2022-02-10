import 'package:themvp/mvp.dart';

import 'double.dart';

// * Use extends instead implements or with.
class Counter extends IPresenter<String, int, String, String> {
  @override
  int model({required String params}) {
    final someResult = int.parse(params) + 1;
    final doubleMe = DoubleMe();
    final result = doubleMe.presenter(someResult);
    return result;
  }

  @override
  String view({required int model}) {
    return model.toString();
  }
}
