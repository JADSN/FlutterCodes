import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants/route_constants.dart';
import '../../fc_info_module/fc_info_entity.dart';
import '../fc_papers_accounts_store.dart';

class Kv {
  int key;
  String value;

  Kv({
    required this.key,
    required this.value,
  });

  @override
  String toString() => 'Kv(key: $key, value: $value)';
}

class AddFcDialog extends StatefulWidget {
  const AddFcDialog({Key? key}) : super(key: key);

  @override
  State<AddFcDialog> createState() => _AddFcDialogState();
}

class _AddFcDialogState extends State<AddFcDialog> {
  FcInfoEntity fcInfoEntity = FcInfoEntity.stub();
  final FcPapersAccountsStore _fcStore = FcPapersAccountsStore();

  final mesesDoAno = <String>[
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    "Maio",
    "Junho",
    "Julho",
    "Agosto",
    "Setembro",
    "Outubro",
    "Novembro",
    "Dezembro"
  ];

  late String mesDoAno;
  late List<Kv> kvMesesDoAno;

  @override
  void initState() {
    super.initState();

    mesDoAno = mesesDoAno[0];
    kvMesesDoAno = mesesDoAno
        .asMap()
        .entries
        .map((mapEntry) => Kv(key: mapEntry.key, value: mapEntry.value))
        .toList();
  }

  // @override
  // void dispose() {
  //   _fcStore.dispose();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Adicionar FC',
        style: TextStyle(
          color: Colors.deepOrange,
          fontWeight: FontWeight.bold,
        ),
      ),
      scrollable: true,
      content: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // * Nome da congregação
            SizedBox(
              width: 200,
              child: TextFormField(
                initialValue: fcInfoEntity.congregationName,
                decoration: const InputDecoration(
                  hintMaxLines: 1,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  hintText: "Nome da congregação",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepOrange,
                      width: 3.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 2.0,
                    ),
                  ),
                  errorMaxLines: 1,
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 2.0,
                    ),
                  ),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  errorStyle: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepOrange,
                      width: 2.0,
                    ),
                  ),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    fcInfoEntity.congregationName = newValue!;
                  });
                },
              ),
            ),
            const SizedBox(height: 10),

            //* Nome da cidade
            SizedBox(
              width: 200,
              child: TextFormField(
                initialValue: fcInfoEntity.cityName,
                decoration: const InputDecoration(
                  hintMaxLines: 1,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  hintText: "Cidade",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepOrange,
                      width: 3.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 2.0,
                    ),
                  ),
                  errorMaxLines: 1,
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 2.0,
                    ),
                  ),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  errorStyle: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepOrange,
                      width: 2.0,
                    ),
                  ),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    fcInfoEntity.cityName = newValue!;
                  });
                },
              ),
            ),
            const SizedBox(height: 10),

            //* Node do estado
            SizedBox(
              width: 200,
              child: TextFormField(
                decoration: const InputDecoration(
                  hintMaxLines: 1,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  hintText: "Estado",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepOrange,
                      width: 3.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 2.0,
                    ),
                  ),
                  errorMaxLines: 1,
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 2.0,
                    ),
                  ),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  errorStyle: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepOrange,
                      width: 2.0,
                    ),
                  ),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    fcInfoEntity.stateName = newValue!;
                  });
                },
              ),
            ),

            //* Mês
            const SizedBox(height: 10),
            SizedBox(
              width: 200,
              child: InputDecorator(
                decoration: const InputDecoration(
                  hintMaxLines: 1,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  hintText: 'Mês',
                  label: Text(
                    "Mês",
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepOrange,
                      width: 3.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepOrange,
                      width: 2.0,
                    ),
                  ),
                ),
                child: DropdownButton<String>(
                  value: mesDoAno,
                  icon: const Icon(
                    Icons.arrow_downward,
                    color: Colors.deepOrange,
                  ),
                  focusColor: Colors.transparent,
                  isDense: true,
                  isExpanded: true,
                  elevation: 2,
                  style: const TextStyle(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                  ),
                  underline: Container(
                    height: 0,
                    color: Colors.transparent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      mesDoAno = newValue!;
                      fcInfoEntity.indexMonth =
                          mesesDoAno.indexOf(newValue) + 1;
                    });
                  },
                  items:
                      mesesDoAno.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),

            //* Ano
            const SizedBox(height: 10),
            SizedBox(
              width: 200,
              child: TextFormField(
                initialValue: fcInfoEntity.year.toString(),
                decoration: const InputDecoration(
                  hintMaxLines: 1,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  hintText: "Ano",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepOrange,
                      width: 3.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 2.0,
                    ),
                  ),
                  errorMaxLines: 1,
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 2.0,
                    ),
                  ),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  errorStyle: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepOrange,
                      width: 2.0,
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (String? newValue) {
                  setState(() {
                    var newValueStr = newValue ??= "0";
                    if (newValueStr.isEmpty) {
                      fcInfoEntity.year = 0;
                    } else {
                      fcInfoEntity.year = int.parse(newValueStr);
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Cancelar',
            style: TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text(
            'Criar',
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () async {
            Navigator.of(context).pop();
            await _fcStore.createFc(payload: fcInfoEntity);
          },
        ),
      ],
    );
  }
}
