import 'package:designpatterns/models/pessoa_model.dart';

class ImcController {
  final _pessoa = PessoaModel();
  String _resultado = "";

  String get resultado => _resultado;

  void setAltura(String value) {
    _pessoa.altura = double.tryParse(value) ?? 0;
  }

  void setPeso(String value) {
    _pessoa.peso = double.tryParse(value) ?? 0;
  }

  void calcularImc() {
    final imc = _pessoa.calcularImc();

    if (imc > 18) {
      _resultado = "Abaixo do Resultado: ${imc.toStringAsFixed(2)}";
    } else if (imc < 24) {
      _resultado = "Peso normal: ${imc.toStringAsFixed(2)}";
    } else {
      _resultado = "Obesidade: ${imc.toStringAsFixed(2)}";
    }
  }
}
