import 'package:archer/layers/domain/entities/car_entity.dart';

abstract class GetCarsByColorUsecase {
  CarEntity call(String color);
}
