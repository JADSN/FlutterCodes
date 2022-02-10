import 'package:test/test.dart';

import 'package:themvp/main.dart';

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

void main(List<String> args) {
  test('Call another presenter - doubling the value.', () {
    Counter counter = Counter();
    final output = counter.presenter("42");
    print("[OUTPUT]: $output");

    expect(output, equals("86"));
  });
}
