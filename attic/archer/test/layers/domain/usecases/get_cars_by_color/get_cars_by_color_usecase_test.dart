import 'package:archer/layers/domain/entities/car_entity.dart';
import 'package:archer/layers/domain/repositories/get_cars_by_color_repository.dart';
import 'package:archer/layers/domain/usecases/get_cars_by_color/get_cars_by_color_usecase.dart';
import 'package:archer/layers/domain/usecases/get_cars_by_color/get_cars_by_color_usecase_impl.dart';
import 'package:flutter_test/flutter_test.dart';

class GetCarsByColorRepositoryImpl implements GetCarsByColorRepository {
  @override
  CarEntity call(String color) {
    if (color.contains("red")) {
      return CarEntity(plate: "ABC-1234", qtdePorts: 4, price: 5.000);
    }
    return CarEntity(plate: "QWE-4567", qtdePorts: 2, price: 2.000);
  }
}

void main() {
  test('Should return a car when passed any color.', () {
    GetCarsByColorUsecase getCarsByColorUsecase = GetCarsByColorUsecaseImpl(
      GetCarsByColorRepositoryImpl(),
    );

    var expectedResult = getCarsByColorUsecase("blue");

    expect(expectedResult, isInstanceOf<CarEntity>());
  });

  test('Should return a car with qtdePorts eguals to 4 when color red.', () {
    GetCarsByColorUsecase getCarsByColorUsecase = GetCarsByColorUsecaseImpl(
      GetCarsByColorRepositoryImpl(),
    );

    var expectedResult = getCarsByColorUsecase("red");

    expect(expectedResult.qtdePorts, 4);
  });

  test(
      'Should return a car with qtdePorts eguals to 2 when any color except red.',
      () {
    GetCarsByColorUsecase getCarsByColorUsecase = GetCarsByColorUsecaseImpl(
      GetCarsByColorRepositoryImpl(),
    );

    var expectedResult = getCarsByColorUsecase("green");

    expect(expectedResult.qtdePorts, 2);
  });
}
