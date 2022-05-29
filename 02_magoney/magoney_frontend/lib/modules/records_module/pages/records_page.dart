import 'package:flutter/material.dart';
import 'package:magoney_frontend/modules/records_module/entities/record_entity.dart';

import 'package:magoney_frontend/modules/records_module/stores/record_store.dart';
import 'package:magoney_frontend/modules/records_module/widgets/record_add_dialog_widget.dart';

import '../../../widgets/custom_app_bar_widget.dart';
import '../../../widgets/custom_drawer_widget.dart';
import '../states/record_state.dart';
import '../widgets/record_edit_dialog_widget.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({Key? key}) : super(key: key);

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  late final RecordStore _recordStore;

  String recordDescription = "";
  DateTime recordDate = DateTime.now();
  String symbol = "O";

  double donateInput = 0.00;
  double donateOutput = 0.00;

  double bankAccoutInput = 0.00;
  double bankAccoutOutput = 0.00;

  double otherInput = 0.00;
  double otherOutput = 0.00;

  @override
  void initState() {
    super.initState();

    _recordStore = RecordStore();
  }

  @override
  void dispose() {
    _recordStore.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(appBarTitleText: "Registros"),
      drawer: const CustomDrawerWidget(),
      body: ValueListenableBuilder<RecordState>(
        valueListenable: _recordStore,
        builder: (BuildContext context, RecordState state, child) {
          if (state is RecordLoadingState) {
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
          } else if (state is RecordErrorState) {
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
          } else if (state is RecordSuccessState) {
            final list = state.payload;
            return RawScrollbar(
              thumbColor: Colors.deepPurple,
              trackColor: Colors.deepPurple,
              trackBorderColor: Colors.deepPurple,
              radius: const Radius.circular(20),
              thickness: 5,
              child: list.isEmpty
                  ? const Center(
                      child: Text(
                        'SEM REGISTROS',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final item = list.elementAt(index);
                        return ListTile(
                          title: Text(item.code.toString()),
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
                                    await _recordStore
                                        .deleteOneByCode(code: item.code)
                                        .whenComplete(
                                          () async => _recordStore.getAll(),
                                        );
                                  },
                                ),
                                InkWell(
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.amberAccent,
                                  ),
                                  onTap: () async {
                                    final RecordReadAllEntity payload =
                                        state.payload.firstWhere(
                                      (element) => element.code == item.code,
                                    );

                                    showDialog<void>(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (_) => RecordEditDialogWidget(
                                        recordStore: _recordStore,
                                        recordReadAllEntity: payload,
                                      ),
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
        child: const Icon(Icons.plus_one),
        onPressed: () {
          showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => RecordAddDialogWidget(
              recordStore: _recordStore,
            ),
          );
        },
      ),
    );
  }
}
