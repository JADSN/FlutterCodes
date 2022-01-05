import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfire_ui/firestore.dart';

import 'package:todolistfirebase/models/task_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final CollectionReference<TaskModel> tasksRef = FirebaseFirestore.instance
    .collection(TaskModel.collectionName)
    .withConverter<TaskModel>(
      fromFirestore: (snapshots, _) => TaskModel.fromMap(snapshots.data()!),
      toFirestore: (task, _) => task.toMap(),
    );

class _HomePageState extends State<HomePage> {
  late TextEditingController descriptionTask;

  @override
  void initState() {
    super.initState();

    descriptionTask = TextEditingController(text: null);
  }

  @override
  void dispose() {
    super.dispose();

    descriptionTask.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirestoreQueryBuilder<TaskModel>(
        query: tasksRef.orderBy('createdAt', descending: true),
        builder: (BuildContext context,
            FirestoreQueryBuilderSnapshot<TaskModel> snapshot, Widget? _) {
          var docs = snapshot.docs;

          if (docs.isEmpty) {
            return const Center(
              child: Text(
                "NO ITEMS",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          if (snapshot.isFetching) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Text('error ${snapshot.error}');
          }

          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.docs.length,
              itemBuilder: (context, index) {
                if (snapshot.hasMore && index + 1 == docs.length) {
                  snapshot.fetchMore();
                }

                final taskQuery = docs[index];
                final taskDocument = taskQuery.data();

                final String formattedDate = DateFormat(
                  'dd-MM-yyyy - HH:mm:ss',
                ).format(
                  taskDocument.createdAt.toDate(),
                );

                return ExpansionTile(
                  leading: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: InkWell(
                      child: const Icon(
                        Icons.remove_circle_outline,
                        color: Colors.red,
                      ),
                      onTap: () {
                        final taskDocumentCode = taskDocument.code;

                        FirebaseFirestore.instance
                            .collection(TaskModel.collectionName)
                            .where(TaskModel.codeFieldName,
                                isEqualTo: taskDocumentCode)
                            .get()
                            .then((value) {
                          for (var element in value.docs) {
                            FirebaseFirestore.instance
                                .collection(TaskModel.collectionName)
                                .doc(element.id)
                                .delete();
                          }
                        });
                      },
                    ),
                  ),
                  trailing: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        child: const Icon(
                          Icons.edit,
                          color: Colors.orangeAccent,
                        ),
                        onTap: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Edit description task'),
                              content: TextFormField(
                                initialValue: taskDocument.description,
                                onChanged: (String value) =>
                                    descriptionTask.text = value,
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    final taskDocumentCode = taskDocument.code;
                                    FirebaseFirestore.instance
                                        .collection(TaskModel.collectionName)
                                        .where(TaskModel.codeFieldName,
                                            isEqualTo: taskDocumentCode)
                                        .get()
                                        .then((value) {
                                      for (var element in value.docs) {
                                        FirebaseFirestore.instance
                                            .collection(
                                                TaskModel.collectionName)
                                            .doc(element.id)
                                            .update({
                                          TaskModel.descriptionFieldName:
                                              descriptionTask.text,
                                        });
                                      }
                                    });

                                    Navigator.pop(context, 'Edit');
                                  },
                                  child: const Text('Edit'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Checkbox(
                        value: taskDocument.isDone,
                        shape: const CircleBorder(),
                        onChanged: (bool? newValueIsDone) {
                          final taskDocumentCode = taskDocument.code;
                          FirebaseFirestore.instance
                              .collection(TaskModel.collectionName)
                              .where(TaskModel.codeFieldName,
                                  isEqualTo: taskDocumentCode)
                              .get()
                              .then((value) {
                            for (var element in value.docs) {
                              FirebaseFirestore.instance
                                  .collection(TaskModel.collectionName)
                                  .doc(element.id)
                                  .update({
                                TaskModel.isDoneFieldName: newValueIsDone,
                              });
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  title: Text(
                    taskDocument.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  expandedAlignment: Alignment.centerLeft,
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  tilePadding: const EdgeInsets.all(10),
                  subtitle: Text(formattedDate),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        taskDocument.description,
                        maxLines: 3,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          }

          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.plus_one),
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Add task'),
              content: TextFormField(
                initialValue: "",
                onChanged: (String value) => descriptionTask.text = value,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    var dataToAdd = TaskModel(
                      code: const Uuid().v4(),
                      description: descriptionTask.text,
                      isDone: false,
                      createdAt: Timestamp.now(),
                    ).toMap();

                    await FirebaseFirestore.instance
                        .collection(TaskModel.collectionName)
                        .add(dataToAdd);

                    Navigator.pop(context, 'OK');
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
