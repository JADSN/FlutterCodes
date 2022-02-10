import 'package:test/test.dart';

import 'package:themvp/main.dart';

// * Use extends instead implements or with.
class Counter extends IPresenter<String, int, String, String> {
  @override
  int model({required String params}) {
    print("[MODEL]: $params");
    return int.parse(params) + 1;
  }

  @override
  String view({required int model}) {
    return model.toString();
  }
}

void main(List<String> args) {
  test('Incremnt one', () {
    Counter counter = Counter();
    final output = counter.presenter("42");
    print("[OUTPUT]: $output");

    expect(output, equals("43"));
  });
}
