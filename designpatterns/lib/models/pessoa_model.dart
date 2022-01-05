import 'dart:math';

class PessoaModel {
  double _altura = 0.0;
  double _peso = 0.0;

  set altura(double value) => _altura = value;
  set peso(double value) => _peso = value;

  double calcularImc() {
    double imc = _peso / pow(_altura, 2);
    return imc;
  }
}
