import 'package:designpatterns/viewmodel/imc_viewmodel.dart';
import 'package:flutter/material.dart';

// * Presenter
// import 'package:designpatterns/presenter/imc_presenter.dart';
// import 'package:designpatterns/presenter/imc_view_presenter.dart';

class ImcPage extends StatefulWidget {
  const ImcPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ImcPage> createState() => _ImcPageState();
}

// * Uncomment for MVP
// class _ImcPageState extends State<ImcPage> implements ImcViewPresenter {
class _ImcPageState extends State<ImcPage> {
  // * Controller
  // final _controller = ImcController();

  // * Presenter
  // late final _presenter = ImcPresenter(contract: this);

  final _viewmodel = ImcViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CALCULADORA IMC"),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  keyboardType: TextInputType.number,
                  // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Peso",
                  ),
                  onChanged: _viewmodel.setPeso,
                ),
                const SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.number,
                  // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Altura",
                  ),
                  onChanged: _viewmodel.setAltura,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => setState(() => _viewmodel.calcularImc()),
                  child: const Text(
                    "CALCULAR",
                  ),
                ),
                const SizedBox(height: 20),
                // Text(
                //   _viewmodel.resultado,
                //   style: const TextStyle(
                //     fontWeight: FontWeight.bold,
                //   ),
                // )
                AnimatedBuilder(
                  animation: _viewmodel,
                  builder: (context, child) {
                    return Text(
                      _viewmodel.resultado,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // * For MVP
  // @override
  // void update() {
  //   setState(() {});
  // }
}
