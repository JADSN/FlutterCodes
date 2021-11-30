import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:taskermobx/globals/global_scaffold.dart';
import 'package:taskermobx/states/crud_state.dart';
import 'package:taskermobx/stores/task_store.dart';

class TaskListComponent extends StatefulWidget {
  final TaskStore taskStore;

  const TaskListComponent({
    Key? key,
    required this.taskStore,
  }) : super(key: key);

  @override
  _TaskListComponentState createState() => _TaskListComponentState();
}

class _TaskListComponentState extends State<TaskListComponent> {
  @override
  Widget build(BuildContext context) {
    return widget.taskStore.listOfTasks.isEmpty
        ? const Center(
            child: Text(
            "EMPTY LIST",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ))
        : ListView.builder(
            itemCount: widget.taskStore.listOfTasks.length,
            itemBuilder: (BuildContext context, int index) {
              var task = widget.taskStore.listOfTasks[index];
              return ListTile(
                title: Text(task.description),
                leading: Text(task.id.toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        color: Colors.brown,
                        onPressed: () {
                          widget.taskStore
                              .removeTaskFromList(index)
                              .whenComplete(() {
                            if (widget.taskStore.crudState == CrudState.nop &&
                                widget.taskStore.failure.isNone()) {
                              const snackBar = SnackBar(
                                backgroundColor: Color.fromRGBO(35, 92, 0, 36),
                                content: Text(
                                  'Item removed from the list.',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(128, 255, 68, 88),
                                  ),
                                ),
                              );

                              GlobalScaffold.instance.showSnackbar(snackBar);

                              widget.taskStore.description = "";
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.red,
                        )),
                    IconButton(
                        color: Colors.brown,
                        onPressed: () => showDialog<void>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Update description:'),
                                content: TextFormField(
                                    initialValue: "",
                                    onChanged: (value) =>
                                        widget.taskStore.description = value),
                                actions: <Widget>[
                                  TextButton(
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.red),
                                    ),
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.blue),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context, 'OK');

                                      widget.taskStore
                                          .updateOneTask(index)
                                          .whenComplete(() {
                                        if (widget.taskStore.crudState ==
                                                CrudState.nop &&
                                            widget.taskStore.failure.isNone()) {
                                          const snackBar = SnackBar(
                                            backgroundColor:
                                                Color.fromRGBO(35, 92, 0, 36),
                                            content: Text(
                                              'New task added to the list.',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(
                                                    128, 255, 68, 88),
                                              ),
                                            ),
                                          );

                                          GlobalScaffold.instance
                                              .showSnackbar(snackBar);

                                          widget.taskStore.description = "";
                                        }
                                      });
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            ),
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.orange,
                        )),
                  ],
                ),
              );
            },
          );
  }
}
