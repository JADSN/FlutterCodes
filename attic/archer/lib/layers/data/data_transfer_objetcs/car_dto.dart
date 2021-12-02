import 'dart:convert';

import 'package:archer/layers/domain/entities/car_entity.dart';

class CarDto extends CarEntity {
  String plate;
  int amountOfPorts;
  double finalPrice;

  CarDto({
    required this.plate,
    required this.amountOfPorts,
    required this.finalPrice,
  }) : super(plate: plate, qtdePorts: amountOfPorts, price: finalPrice);

  Map<String, dynamic> toMap() {
    return {
      'plate': plate,
      'amountOfPorts': amountOfPorts,
      'finalPrice': finalPrice,
    };
  }

  factory CarDto.fromMap(Map<String, dynamic> map) {
    return CarDto(
      plate: map['plate'],
      amountOfPorts: map['amountOfPorts'],
      finalPrice: map['finalPrice'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CarDto.fromJson(String source) => CarDto.fromMap(json.decode(source));

  CarDto copyWith({
    String? plate,
    int? amountOfPorts,
    double? finalPrice,
  }) {
    return CarDto(
      plate: plate ?? this.plate,
      amountOfPorts: amountOfPorts ?? this.amountOfPorts,
      finalPrice: finalPrice ?? this.finalPrice,
    );
  }
}
