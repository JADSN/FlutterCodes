import 'package:archer/layers/data/repositories/get_cars_by_color_repository_impl.dart';
import 'package:archer/layers/domain/repositories/get_cars_by_color_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  GetCarsByColorRepository repository = GetCarsByColorRepositoryImpl();
  test('Get a car regardless of color ', () async {
    var result = repository('any');

    expect(result, isNotNull);
  });
}
