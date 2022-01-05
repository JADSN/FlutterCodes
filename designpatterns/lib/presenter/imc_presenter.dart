import 'package:designpatterns/models/pessoa_model.dart';
import 'package:designpatterns/presenter/imc_view_presenter.dart';

class ImcPresenter {
  final _pessoa = PessoaModel();
  String _resultado = "";

  final ImcViewPresenter contract;

  ImcPresenter({
    required this.contract,
  });

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

    contract.update();
  }
}
