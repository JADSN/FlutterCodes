import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../utils/get_color.dart';
import '../commons/receipt_group.dart';
import '../entities/receipt_entity.dart';
import '../states/receipt_state.dart';
import '../stores/receipt_store.dart';

class ReceiptEditDialogWidget extends StatefulWidget {
  final ReceiptStore receiptStore;

  final ReceiptReadAllEntity receiptReadAllEntity;

  const ReceiptEditDialogWidget({
    Key? key,
    required this.receiptStore,
    required this.receiptReadAllEntity,
  }) : super(key: key);

  @override
  State<ReceiptEditDialogWidget> createState() => _ReceiptEditDialogState();
}

class _ReceiptEditDialogState extends State<ReceiptEditDialogWidget> {
  ReceiptGroup? _receiptGroup = ReceiptGroup.donate;

  late ValueNotifier<double> receiptDonateWorldWork;
  late ValueNotifier<double> receiptLocalCongregationExpenses;

  late DateTime receiptDate;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    receiptDonateWorldWork =
        ValueNotifier(widget.receiptReadAllEntity.donateWorldWork / 100);

    receiptLocalCongregationExpenses = ValueNotifier(
        widget.receiptReadAllEntity.localCongregationExpenses / 100);

    receiptDate = DateTime.parse(
      '${widget.receiptReadAllEntity.collectionDate} 00:00:00.000',
    );

    switch (widget.receiptReadAllEntity.receiptType) {
      case 1:
        _receiptGroup = ReceiptGroup.donate;
        break;
      case 2:
        _receiptGroup = ReceiptGroup.bankDeposit;
        break;
      case 3:
        _receiptGroup = ReceiptGroup.payment;
        break;
      case 4:
        _receiptGroup = ReceiptGroup.advancyMoney;
        break;
      default:
    }
  }

  @override
  void dispose() {
    receiptDonateWorldWork.dispose();
    receiptLocalCongregationExpenses.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text(
        'Editar recibo',
        style: TextStyle(
          color: Colors.deepPurple,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Escolha o tipo",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                  strutStyle: StrutStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 200,
                  child: InputDatePickerFormField(
                    initialDate: receiptDate,
                    firstDate: receiptDate,
                    lastDate: receiptDate,
                    fieldLabelText: "Data",
                    keyboardType: TextInputType.datetime,
                    autofocus: true,
                    errorFormatText: "Data Invalida",
                    fieldHintText: "yyyy-mm-dd",
                    onDateSaved: (DateTime? newDate) => receiptDate = newDate!,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<ReceiptGroup>(
                  activeColor: Colors.deepPurple,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: ReceiptGroup.donate,
                  groupValue: _receiptGroup,
                  onChanged: (ReceiptGroup? newValue) => setState(() {
                    _receiptGroup = newValue!;
                  }),
                ),
                const Text(
                  "Donativo",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<ReceiptGroup>(
                  activeColor: Colors.deepPurple,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: ReceiptGroup.bankDeposit,
                  groupValue: _receiptGroup,
                  onChanged: (ReceiptGroup? newValue) => setState(() {
                    _receiptGroup = newValue!;
                  }),
                ),
                const Text(
                  "Depósito no cofre",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<ReceiptGroup>(
                  activeColor: Colors.deepPurple,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: ReceiptGroup.payment,
                  groupValue: _receiptGroup,
                  onChanged: (ReceiptGroup? newValue) => setState(() {
                    _receiptGroup = newValue!;
                  }),
                ),
                const Text(
                  "Pagamento",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<ReceiptGroup>(
                  activeColor: Colors.deepPurple,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: ReceiptGroup.advancyMoney,
                  groupValue: _receiptGroup,
                  onChanged: (ReceiptGroup? newValue) => setState(() {
                    _receiptGroup = newValue!;
                  }),
                ),
                const Text(
                  "Adiantamento",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Donativos — Obra mundial",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    initialValue:
                        (receiptDonateWorldWork.value).toStringAsFixed(2),
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
                    onChanged: (String newValue) {
                      setState(
                        () {
                          receiptDonateWorldWork.value =
                              double.tryParse(newValue) ?? 0.00;
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Donativos — Despesas da congregação local",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    initialValue: (receiptLocalCongregationExpenses.value)
                        .toStringAsFixed(2),
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
                      () => receiptLocalCongregationExpenses.value =
                          double.tryParse(newValue) ?? 0.00,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder<double>(
              valueListenable: receiptDonateWorldWork,
              builder: (context, valueOfreceiptDonateWorldWork, _) {
                return ValueListenableBuilder<double>(
                  valueListenable: receiptLocalCongregationExpenses,
                  builder:
                      (context, valueOfReceiptLocalCongregationExpenses, _) {
                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'TOTAL',
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ((valueOfreceiptDonateWorldWork +
                                  valueOfReceiptLocalCongregationExpenses))
                              .toStringAsFixed(2),
                          style: const TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
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
        ValueListenableBuilder<ReceiptState>(
          valueListenable: widget.receiptStore,
          builder: (BuildContext context, ReceiptState state, _) {
            return TextButton(
              child: const Text(
                'Atualizar',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final fmtDate =
                      "${receiptDate.year}-${receiptDate.month}-${receiptDate.day}";

                  final donateWorldWorkCents =
                      (receiptDonateWorldWork.value * 100).toInt();

                  final localCongregationExpensesCents =
                      (receiptLocalCongregationExpenses.value * 100).toInt();

                  final payload = ReceiptUpdateEntity(
                    collectionDate: fmtDate,
                    donateWorldWork: donateWorldWorkCents,
                    localCongregationExpenses: localCongregationExpensesCents,
                    receiptType: _receiptGroup!.index + 1,
                  );

                  log(payload.toString());

                  Navigator.of(context).pop();

                  await widget.receiptStore
                      .updateOneByCode(
                    code: widget.receiptReadAllEntity.code,
                    payload: payload,
                  )
                      .whenComplete(
                    () async {
                      // * Refresh list.
                      await widget.receiptStore.getAll();
                    },
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}