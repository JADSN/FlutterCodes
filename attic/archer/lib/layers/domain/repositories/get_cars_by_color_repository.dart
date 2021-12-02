import 'package:archer/layers/domain/entities/car_entity.dart';

abstract class GetCarsByColorRepository {
  CarEntity call(String color);
}
