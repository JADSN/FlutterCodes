// * 1. No api calls.
// * 2. Only imports of layer domain.

import 'package:archer/layers/domain/entities/car_entity.dart';
import 'package:archer/layers/domain/repositories/get_cars_by_color_repository.dart';
import 'package:archer/layers/domain/usecases/get_cars_by_color/get_cars_by_color_usecase.dart';

class GetCarsByColorUsecaseImpl implements GetCarsByColorUsecase {
  final GetCarsByColorRepository _getCarsByColorRepository;

  GetCarsByColorUsecaseImpl(this._getCarsByColorRepository);

  @override
  CarEntity call(String color) {
    return _getCarsByColorRepository(color);
  }
}
