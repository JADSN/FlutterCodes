import 'dart:math';

import 'package:designpatterns/viewmodel/pessoa_model_view_model.dart';
import 'package:flutter/foundation.dart';

class ImcViewModel extends ChangeNotifier {
  var _pessoa = const PessoaModelViewModel();
  String _resultado = "";

  String get resultado => _resultado;

  void setAltura(String value) {
    _pessoa = PessoaModelViewModel(
      altura: double.tryParse(value) ?? 0,
      peso: _pessoa.peso,
    );
  }

  void setPeso(String value) {
    _pessoa = PessoaModelViewModel(
      altura: _pessoa.altura,
      peso: double.tryParse(value) ?? 0,
    );
  }

  void calcularImc() {
    final imc = _pessoa.peso / pow(_pessoa.altura, 2);

    if (imc > 18) {
      _resultado = "Abaixo do Resultado: ${imc.toStringAsFixed(2)}";
    } else if (imc < 24) {
      _resultado = "Peso normal: ${imc.toStringAsFixed(2)}";
    } else {
      _resultado = "Obesidade: ${imc.toStringAsFixed(2)}";
    }

    notifyListeners();
  }
}
