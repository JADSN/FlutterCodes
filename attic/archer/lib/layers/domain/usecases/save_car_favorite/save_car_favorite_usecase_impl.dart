// * I don't know how to save. Ex: API, Firebase, database, etc;
//* 1. Delegate the how implement the feature to repository;
//* 1.1. Dependency inversion.
//* 3. Can use another usecases of the same layer domain.
//* 4. Normally is asynchronous.

import 'package:archer/layers/domain/entities/car_entity.dart';
import 'package:archer/layers/domain/repositories/save_car_favorite_repository.dart';
import 'package:archer/layers/domain/usecases/save_car_favorite/save_car_favorite_usecase.dart';

class SaveCarFavoriteUsecaseImpl implements SaveCarFavoriteUsecase {
  final SaveCarFavoriteRepository _saveCarFavoriteRepository;

  SaveCarFavoriteUsecaseImpl(this._saveCarFavoriteRepository);

  @override
  Future<bool> call(CarEntity carEntity) async {
    //* Usage of an usecase of the same layer domain.
    carEntity.setLogic();
    return await _saveCarFavoriteRepository(carEntity);
  }
}
