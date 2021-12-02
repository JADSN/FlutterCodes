import 'package:archer/layers/domain/entities/car_entity.dart';
import 'package:archer/layers/domain/repositories/save_car_favorite_repository.dart';
import 'package:archer/layers/domain/usecases/save_car_favorite/save_car_favorite_usecase.dart';
import 'package:archer/layers/domain/usecases/save_car_favorite/save_car_favorite_usecase_impl.dart';
import 'package:flutter_test/flutter_test.dart';

class SaveCarFavoriteRepositoryImpl implements SaveCarFavoriteRepository {
  @override
  Future<bool> call(CarEntity carEntity) async {
    return carEntity.price > 0;
  }
}

void main() {
  test('Save favorite car with success', () async {
    SaveCarFavoriteUsecase saveCarFavoriteUsecase =
        SaveCarFavoriteUsecaseImpl(SaveCarFavoriteRepositoryImpl());

    var carEntity = CarEntity(plate: "plate", qtdePorts: 2, price: 1.0);

    var expectedResult = await saveCarFavoriteUsecase(carEntity);

    expect(expectedResult, true);
  });

  test('Not save favorite car when price less than or equal to zero', () async {
    SaveCarFavoriteUsecase saveCarFavoriteUsecase =
        SaveCarFavoriteUsecaseImpl(SaveCarFavoriteRepositoryImpl());

    var carEntity = CarEntity(plate: "plate", qtdePorts: 2, price: 0);

    var expectedResult = await saveCarFavoriteUsecase(carEntity);

    expect(expectedResult, false);
  });
}
