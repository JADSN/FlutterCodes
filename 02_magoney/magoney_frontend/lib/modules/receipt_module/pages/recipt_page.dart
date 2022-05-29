import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:magoney_frontend/modules/receipt_module/entities/receipt_entity.dart';
import 'package:magoney_frontend/modules/receipt_module/states/receipt_state.dart';
import 'package:magoney_frontend/modules/receipt_module/stores/receipt_store.dart';
import 'package:magoney_frontend/modules/receipt_module/widgets/receipt_add_dialog_widget.dart';
import 'package:magoney_frontend/modules/receipt_module/widgets/receipt_edit_dialog_widget.dart';
import 'package:magoney_frontend/widgets/custom_app_bar_widget.dart';
import 'package:magoney_frontend/widgets/custom_drawer_widget.dart';

Color getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
    MaterialState.disabled,
    MaterialState.selected,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.deepPurple;
  }
  return Colors.deepPurple;
}

class ReceiptPage extends StatefulWidget {
  const ReceiptPage({Key? key}) : super(key: key);

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  final _receiptStore = ReceiptStore();

  @override
  void initState() {
    super.initState();

    _receiptStore.getAll();
  }

  @override
  void dispose() {
    _receiptStore.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(appBarTitleText: "Recibos"),
      drawer: const CustomDrawerWidget(),
      body: ValueListenableBuilder<ReceiptState>(
        valueListenable: _receiptStore,
        builder: (BuildContext context, ReceiptState state, _) {
          if (state is ReceiptLoadingState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    color: Colors.deepPurple,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    state.label,
                    style: const TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            );
          } else if (state is ReceiptErrorState) {
            return Center(
              child: Text(
                state.errorMessage,
                maxLines: 10,
                overflow: TextOverflow.visible,
                style: const TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else if (state is ReceiptSuccessState) {
            final list = state.payload;
            return list.isEmpty
                ? const Center(
                    child: Text(
                      'SEM RECIBOS',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  )
                : RawScrollbar(
                    thumbColor: Colors.deepPurple,
                    trackColor: Colors.deepPurple,
                    trackBorderColor: Colors.deepPurple,
                    radius: const Radius.circular(20),
                    thickness: 5,
                    child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final ReceiptReadAllEntity item = list.elementAt(index);
                        final subtitleFirstLine = r"Obra Mundial: R$"
                            "${(item.donateWorldWork / 100).toStringAsFixed(2)}";

                        final subtitleSecondLine =
                            r"Despesas da congregação local: R$"
                            "${(item.localCongregationExpenses / 100).toStringAsFixed(2)}";

                        return ListTile(
                          isThreeLine: true,
                          title: Text(item.code.toString()),
                          subtitle:
                              Text("$subtitleFirstLine\n$subtitleSecondLine"),
                          trailing: SizedBox(
                            height: double.infinity,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  child: const Icon(
                                    Icons.remove_circle,
                                    color: Colors.redAccent,
                                  ),
                                  onTap: () async {
                                    await _receiptStore
                                        .deleteOneByCode(code: item.code)
                                        .whenComplete(
                                          () async => _receiptStore.getAll(),
                                        );
                                  },
                                ),
                                InkWell(
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.amberAccent,
                                  ),
                                  onTap: () async {
                                    final ReceiptReadAllEntity payload =
                                        state.payload.firstWhere(
                                      (element) => element.code == item.code,
                                    );

                                    showDialog<void>(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (_) => ReceiptEditDialogWidget(
                                          receiptStore: _receiptStore,
                                          receiptReadAllEntity: payload),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
          } else {
            return Container(
              color: Colors.amberAccent,
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        tooltip: "Adicionar",
        child: const Icon(Icons.plus_one),
        onPressed: () {
          showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (_) => ReceiptAddDialogWidget(
              receiptStore: _receiptStore,
            ),
          );
        },
      ),
    );
  }
}
