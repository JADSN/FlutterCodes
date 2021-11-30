import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:taskermobx/components/loading_component.dart';
import 'package:taskermobx/components/task_list_component.dart';
import 'package:taskermobx/exceptions/tasks_error.dart';
import 'package:taskermobx/globals/global_scaffold.dart';
import 'package:taskermobx/models/task_model.dart';
import 'package:taskermobx/states/crud_state.dart';
import 'package:taskermobx/stores/task_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskStore _taskStore = TaskStore();

  @override
  void initState() {
    super.initState();

    reaction((_) => _taskStore.failure, (msg) {
      _taskStore.failure.map((resultFailure) {
        String message = "No Error";
        if (resultFailure is FetchTasksFailure) {
          message = 'Error on load the content.';
        }

        if (resultFailure is NotFoundTaskFailure) {
          message = "Task does not exists";
        }

        if (resultFailure is ServerFailure) {
          message = "Server down";
        }

        SnackBar snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            message,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        );

        GlobalScaffold.instance.showSnackbar(snackBar);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        bool isProcessingData =
            _taskStore.crudState != CrudState.nop && _taskStore.isProcessing;

        return Scaffold(
          key: GlobalScaffold.instance.secretKey,
          body: Center(
            child: isProcessingData
                ? LoadingComponent(taskStore: _taskStore)
                : TaskListComponent(taskStore: _taskStore),
          ),
          floatingActionButton: Visibility(
            visible: _taskStore.crudState == CrudState.nop,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: FloatingActionButton(
                      onPressed: () {
                        _taskStore.readAllTasks().whenComplete(() {
                          if (_taskStore.failure.isNone()) {
                            const snackBar = SnackBar(
                              backgroundColor: Color.fromRGBO(35, 92, 0, 36),
                              content: Text(
                                'List up to date',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(128, 255, 68, 88),
                                ),
                              ),
                            );

                            GlobalScaffold.instance.showSnackbar(snackBar);
                          }
                        });
                      },
                      child: const Icon(Icons.refresh),
                    )),
                FloatingActionButton(
                  backgroundColor: Colors.brown,
                  child: const Icon(Icons.plus_one),
                  onPressed: () => showDialog<void>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Create task'),
                      content: TextFormField(
                          initialValue: "",
                          onChanged: (value) => _taskStore.description = value),
                      actions: <Widget>[
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                          ),
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                          ),
                          onPressed: () {
                            Navigator.pop(context, 'OK');

                            _taskStore.addToList().whenComplete(() {
                              if (_taskStore.crudState == CrudState.nop) {
                                const snackBar = SnackBar(
                                  backgroundColor:
                                      Color.fromRGBO(35, 92, 0, 36),
                                  content: Text(
                                    'New task added to the list.',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(128, 255, 68, 88),
                                    ),
                                  ),
                                );

                                GlobalScaffold.instance.showSnackbar(snackBar);

                                _taskStore.description = "";
                              }
                            });
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
