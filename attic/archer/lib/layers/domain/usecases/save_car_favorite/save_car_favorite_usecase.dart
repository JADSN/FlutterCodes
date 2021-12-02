import 'package:archer/layers/domain/entities/car_entity.dart';

abstract class SaveCarFavoriteUsecase {
  Future<bool> call(CarEntity carEntity);
}
