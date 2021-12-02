// * Same interface of usercase.

import 'package:archer/layers/domain/entities/car_entity.dart';

abstract class SaveCarFavoriteRepository {
  Future<bool> call(CarEntity carEntity);
}
