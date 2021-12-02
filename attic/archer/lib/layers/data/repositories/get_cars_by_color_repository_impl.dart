import 'package:archer/layers/data/data_transfer_objetcs/car_dto.dart';
import 'package:archer/layers/domain/entities/car_entity.dart';
import 'package:archer/layers/domain/repositories/get_cars_by_color_repository.dart';

class GetCarsByColorRepositoryImpl implements GetCarsByColorRepository {
  @override
  CarEntity call(String color) {
    //* Call the api and return a json response.
    var json = {
      'plate': 'ABC-1234',
      'amountOfPorts': 2,
      'finalPrice': 1000.00,
    };

    return CarDto.fromMap(json);
  }
}
