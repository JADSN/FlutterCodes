import 'package:archer/layers/domain/entities/car_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('CarEntity is not null', () {
    CarEntity carEntity =
        CarEntity(plate: "ABC-1234", qtdePorts: 2, price: 1000.00);

    expect(carEntity, isNotNull);
  });

  test('CarEntity quantity of ports egual to 2', () {
    CarEntity carEntity =
        CarEntity(plate: "ABC-1234", qtdePorts: 2, price: 1000.00);

    expect(carEntity.qtdePorts, 2);
  });

  test('CarEntity finalPrice egual to 2000.00', () {
    CarEntity carEntity =
        CarEntity(plate: "ABC-1234", qtdePorts: 2, price: 1000.00);

    var expectedResult = 2000.00;
    expect(carEntity.finalPrice, expectedResult);
  });

  test('CarEntity finalPrice egual to 0.00 when qtdePorts is equal to 0', () {
    CarEntity carEntity =
        CarEntity(plate: "ABC-1234", qtdePorts: 0, price: 1000.00);

    var expectedResult = 0.00;
    expect(carEntity.finalPrice, expectedResult);
  });

  test('CarEntity finalPrice egual to 30000.00', () {
    CarEntity carEntity =
        CarEntity(plate: "ABC-1234", qtdePorts: 2, price: 15000.00);

    var expectedResult = 30000.00;

    carEntity.setLogic();

    expect(carEntity.price, expectedResult);
  });
}
