// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:magoney_frontend/modules/records_module/entities/record_entity.dart';
import 'package:magoney_frontend/modules/records_module/stores/record_store.dart';

class RecordAddDialogWidget extends StatefulWidget {
  final RecordStore recordStore;

  const RecordAddDialogWidget({
    Key? key,
    required this.recordStore,
  }) : super(key: key);

  @override
  State<RecordAddDialogWidget> createState() => _RecordAddDialogWidgetState();
}

class _RecordAddDialogWidgetState extends State<RecordAddDialogWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String recordDescription = "";
  DateTime recordDate = DateTime.now();
  String symbol = "O";
  int actualSymbolListIndexSelected = 1;

  final List<String> symbolList = [
    'O',
    'C',
    'CE',
    'OE',
    'F',
    'J',
    'D',
    'G',
    'GP',
  ];

  double donateInput = 0.00;
  double donateOutput = 0.00;

  double bankAccountInput = 0.00;
  double bankAccountOutput = 0.00;

  double otherInput = 0.00;
  double otherOutput = 0.00;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: AlertDialog(
      scrollable: true,
      title: const Text(
        'Adicionar registro',
        style: TextStyle(
          color: Colors.deepPurple,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            InputDatePickerFormField(
              initialDate: recordDate,
              firstDate: recordDate,
              lastDate: recordDate,
              fieldLabelText: "Data",
              keyboardType: TextInputType.datetime,
              autofocus: true,
              errorFormatText: "Data Invalida",
              fieldHintText: "dd/mm/yyyy",
              onDateSaved: (DateTime? newDate) => recordDate = newDate!,
            ),
            const SizedBox(height: 20),

            InputDecorator(
              decoration: const InputDecoration(
                hintMaxLines: 1,
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
                hintText: 'Símbolo',
                label: Text(
                  "Símbolo",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
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
                    color: Colors.deepPurple,
                    width: 2.0,
                  ),
                ),
              ),
              child: DropdownButton<String>(
                value: symbol,
                icon: const Icon(
                  Icons.arrow_downward,
                  color: Colors.deepPurple,
                ),
                focusColor: Colors.transparent,
                isDense: true,
                isExpanded: true,
                elevation: 2,
                style: const TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
                underline: Container(
                  height: 0,
                  color: Colors.transparent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    int indexSelected = symbolList
                        .indexWhere((element) => newValue! == element);

                    log("INDEX $indexSelected");
                    symbol = newValue!;
                    actualSymbolListIndexSelected = indexSelected + 1;
                  });
                },
                items: symbolList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: recordDescription,
              style: const TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
              cursorColor: Colors.deepPurple,
              autocorrect: false,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: false,
              ),
              decoration: const InputDecoration(
                hintMaxLines: 1,
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
                hintText: 'Descrição',
                label: Text(
                  "Descrição",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
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
                    color: Colors.deepPurple,
                    width: 2.0,
                  ),
                ),
              ),
              onChanged: (String newValue) => setState(
                () => recordDescription = newValue,
              ),
            ),
            const SizedBox(height: 20),

            // * Donativos
            const Text(
              "Donativos",
              style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: donateInput.toStringAsFixed(2),
              style: const TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: false,
              ),
              cursorColor: Colors.deepPurple,
              autocorrect: false,
              autovalidateMode: AutovalidateMode.always,
              validator: (String? value) {
                if (value != null) {
                  String pattern = r'^\d+\.\d{2}$';
                  RegExp regExp = RegExp(pattern);
                  if (regExp.hasMatch(value)) {
                    // var parsedValue = double.tryParse(value) ?? 0.00;
                    return null;
                  } else {
                    return "Número inválido. Exemplo: 123.45";
                  }
                } else {
                  return "Não pode ser vazio";
                }
              },
              decoration: const InputDecoration(
                hintMaxLines: 1,
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
                hintText: 'Entrada',
                label: Text(
                  "Entrada",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
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
                    color: Colors.deepPurple,
                    width: 2.0,
                  ),
                ),
              ),
              onChanged: (String newValue) => setState(
                () => donateInput = double.tryParse(newValue) ?? 0.00,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: donateOutput.toStringAsFixed(2),
              style: const TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
              cursorColor: Colors.deepPurple,
              autocorrect: false,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: false,
              ),
              autovalidateMode: AutovalidateMode.always,
              validator: (String? value) {
                if (value != null) {
                  String pattern = r'^\d+\.\d{2}$';
                  RegExp regExp = RegExp(pattern);
                  if (regExp.hasMatch(value)) {
                    // var parsedValue = double.tryParse(value) ?? 0.00;
                    return null;
                  } else {
                    return "Número inválido. Exemplo: 123.45";
                  }
                } else {
                  return "Não pode ser vazio";
                }
              },
              decoration: const InputDecoration(
                hintMaxLines: 1,
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
                hintText: 'Saída',
                label: Text(
                  "Saída",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                errorStyle: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                    width: 3.0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.redAccent,
                    width: 2.0,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.redAccent,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                    width: 2.0,
                  ),
                ),
              ),
              onChanged: (String newValue) => setState(
                () => donateOutput = double.tryParse(newValue) ?? 0.00,
              ),
            ),

            const SizedBox(height: 20),
            // * Conta bancária / Cofre
            const Text(
              "Conta bancária / Cofre",
              style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: bankAccountInput.toStringAsFixed(2),
              style: const TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
              cursorColor: Colors.deepPurple,
              autocorrect: false,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: false,
              ),
              autovalidateMode: AutovalidateMode.always,
              validator: (String? value) {
                if (value != null) {
                  String pattern = r'^\d+\.\d{2}$';
                  RegExp regExp = RegExp(pattern);
                  if (regExp.hasMatch(value)) {
                    // var parsedValue = double.tryParse(value) ?? 0.00;
                    return null;
                  } else {
                    return "Número inválido. Exemplo: 123.45";
                  }
                } else {
                  return "Não pode ser vazio";
                }
              },
              decoration: const InputDecoration(
                hintMaxLines: 1,
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
                hintText: 'Entrada',
                label: Text(
                  "Entrada",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                errorStyle: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                    width: 3.0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.redAccent,
                    width: 2.0,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.redAccent,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                    width: 2.0,
                  ),
                ),
              ),
              onChanged: (String newValue) => setState(
                () => bankAccountInput = double.tryParse(newValue) ?? 0.00,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: bankAccountOutput.toStringAsFixed(2),
              style: const TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
              cursorColor: Colors.deepPurple,
              autocorrect: false,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: false,
              ),
              autovalidateMode: AutovalidateMode.always,
              validator: (String? value) {
                if (value != null) {
                  String pattern = r'^\d+\.\d{2}$';
                  RegExp regExp = RegExp(pattern);
                  if (regExp.hasMatch(value)) {
                    // var parsedValue = double.tryParse(value) ?? 0.00;
                    return null;
                  } else {
                    return "Número inválido. Exemplo: 123.45";
                  }
                } else {
                  return "Não pode ser vazio";
                }
              },
              decoration: const InputDecoration(
                hintMaxLines: 1,
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
                hintText: 'Saída',
                label: Text(
                  "Saída",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                errorStyle: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                    width: 3.0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.redAccent,
                    width: 2.0,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.redAccent,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                    width: 2.0,
                  ),
                ),
              ),
              onChanged: (String newValue) => setState(
                () => bankAccountOutput = double.tryParse(newValue) ?? 0.00,
              ),
            ),

            const SizedBox(height: 20),
            // * Outra
            const Text(
              "Outra",
              style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: otherInput.toStringAsFixed(2),
              style: const TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: false,
              ),
              autovalidateMode: AutovalidateMode.always,
              validator: (String? value) {
                if (value != null) {
                  String pattern = r'^\d+\.\d{2}$';
                  RegExp regExp = RegExp(pattern);
                  if (regExp.hasMatch(value)) {
                    // var parsedValue = double.tryParse(value) ?? 0.00;
                    return null;
                  } else {
                    return "Número inválido. Exemplo: 123.45";
                  }
                } else {
                  return "Não pode ser vazio";
                }
              },
              cursorColor: Colors.deepPurple,
              autocorrect: false,
              decoration: const InputDecoration(
                hintMaxLines: 1,
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
                hintText: 'Entrada',
                label: Text(
                  "Entrada",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                errorStyle: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                    width: 3.0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.redAccent,
                    width: 2.0,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.redAccent,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                    width: 2.0,
                  ),
                ),
              ),
              onChanged: (String newValue) => setState(
                () => otherInput = double.tryParse(newValue) ?? 0.00,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: otherOutput.toStringAsFixed(2),
              style: const TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
              cursorColor: Colors.deepPurple,
              autocorrect: false,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: false,
              ),
              autovalidateMode: AutovalidateMode.always,
              validator: (String? value) {
                if (value != null) {
                  String pattern = r'^\d+\.\d{2}$';
                  RegExp regExp = RegExp(pattern);
                  if (regExp.hasMatch(value)) {
                    // var parsedValue = double.tryParse(value) ?? 0.00;
                    return null;
                  } else {
                    return "Número inválido. Exemplo: 123.45";
                  }
                } else {
                  return "Não pode ser vazio";
                }
              },
              decoration: const InputDecoration(
                hintMaxLines: 1,
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
                hintText: 'Saída',
                label: Text(
                  "Saída",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                errorStyle: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                    width: 3.0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.redAccent,
                    width: 2.0,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.redAccent,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                    width: 2.0,
                  ),
                ),
              ),
              onChanged: (String newValue) => setState(
                () => otherOutput = double.tryParse(newValue) ?? 0.00,
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
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text(
            'Salvar',
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final date =
                  "${recordDate.year}-${recordDate.month}-${recordDate.day}";

              // TODO Make extension: toCentsMoney and toDecimalMoney.
              final payload = RecordCreateEntity(
                recordDate: date,
                description: recordDescription,
                donateInput: (donateInput * 100).toInt(),
                donateOutput: (donateOutput * 100).toInt(),
                bankAccountInput: (bankAccountInput * 100).toInt(),
                bankAccountOutput: (bankAccountOutput * 100).toInt(),
                otherInput: (otherInput * 100).toInt(),
                otherOutput: (otherOutput * 100).toInt(),
                symbol: actualSymbolListIndexSelected,
              );

              log(payload.toString());

              Navigator.of(context).pop();

              await widget.recordStore.createOne(payload: payload);
            }
          },
        ),
      ],
    ));
  }
}
