import 'package:flutter/material.dart';

import 'package:magoney_frontend/modules/records_module/entities/record_entity.dart';
import 'package:magoney_frontend/modules/records_module/stores/record_store.dart';

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

class RecordEditDialogWidget extends StatefulWidget {
  final RecordStore recordStore;
  final RecordReadAllEntity recordReadAllEntity;

  const RecordEditDialogWidget({
    Key? key,
    required this.recordStore,
    required this.recordReadAllEntity,
  }) : super(key: key);

  @override
  State<RecordEditDialogWidget> createState() => _RecordEditDialogWidgetState();
}

class _RecordEditDialogWidgetState extends State<RecordEditDialogWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String recordDescription;
  late String symbol;

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

  late final List<Kv> symbolListKv;
  late DateTime recordDate;
  late Kv actualSymbolSelected;

  late double donateInput;
  late double donateOutput;

  late double bankAccountInput;
  late double bankAccountOutput;

  late double otherInput;
  late double otherOutput;

  @override
  void initState() {
    super.initState();

    symbolListKv = symbolList
        .asMap()
        .entries
        .map((entry) => Kv(key: entry.key, value: entry.value))
        .toList();

    actualSymbolSelected = symbolListKv.firstWhere(
        (element) => element.key == widget.recordReadAllEntity.symbol - 1);

    recordDescription = widget.recordReadAllEntity.description;

    recordDate =
        DateTime.parse("${widget.recordReadAllEntity.recordDate} 00:00:00.000");

    donateInput = (widget.recordReadAllEntity.donateInput / 100);
    donateOutput = (widget.recordReadAllEntity.donateOutput / 100);

    bankAccountInput = (widget.recordReadAllEntity.bankAccountInput / 100);
    bankAccountOutput = (widget.recordReadAllEntity.bankAccountOutput / 100);

    otherInput = (widget.recordReadAllEntity.otherInput / 100);
    otherOutput = (widget.recordReadAllEntity.otherOutput / 100);
  }

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
              //* Símbolo
              child: DropdownButton<String>(
                value: actualSymbolSelected.value,
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
                    Kv newKv = symbolListKv
                        .firstWhere((element) => element.value == newValue!);

                    actualSymbolSelected = newKv;
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

              // TODO 1: Make extension: toCentsMoney and toDecimalMoney.
              final payload = RecordUpdateEntity(
                recordDate: date,
                description: recordDescription,
                donateInput: (donateInput * 100).toInt(),
                donateOutput: (donateOutput * 100).toInt(),
                bankAccountInput: (bankAccountInput * 100).toInt(),
                bankAccountOutput: (bankAccountOutput * 100).toInt(),
                otherInput: (otherInput * 100).toInt(),
                otherOutput: (otherOutput * 100).toInt(),
                symbol: actualSymbolSelected.key + 1,
              );

              Navigator.of(context).pop();

              await widget.recordStore.updateOneByCode(
                code: widget.recordReadAllEntity.code,
                payload: payload,
              );
            }
          },
        ),
      ],
    ));
  }
}
