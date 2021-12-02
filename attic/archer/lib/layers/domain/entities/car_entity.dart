//* 1. No external imports.
//* 2. Only imports of the same layer.
//* 3. Bussiness logic based on the entity.

class CarEntity {
  String plate;
  int qtdePorts;
  double price;

  CarEntity({
    required this.plate,
    required this.qtdePorts,
    required this.price,
  });

  double get finalPrice => price * qtdePorts;

  setLogic() {
    if (finalPrice > 10000.00) {
      price *= 2;
    }
  }
}
