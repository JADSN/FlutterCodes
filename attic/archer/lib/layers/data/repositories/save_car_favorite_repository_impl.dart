import 'package:archer/layers/domain/entities/car_entity.dart';
import 'package:archer/layers/domain/repositories/save_car_favorite_repository.dart';

class SaveCarFavoriteRepositoryImpl implements SaveCarFavoriteRepository {
  @override
  Future<bool> call(CarEntity carEntity) async {
    return carEntity.price > 0;
  }
}
