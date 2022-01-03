import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:fluttask/models/task_model.dart';
import 'package:fluttask/pages/home/home_controller.dart';

class TaskListItemComponent extends StatelessWidget {
  final HomeController controller;
  final Task task;

  const TaskListItemComponent({
    Key? key,
    required this.controller,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dateFormatted = DateFormat("yyyy-MM-DD HH:mm:ss");
    var createdAt = dateFormatted.format(task.createdAt);

    return ListTile(
      title: Text(task.description),
      subtitle: Text(createdAt),
      leading: InkWell(
        child: const Icon(
          Icons.remove_circle_outline,
          color: Colors.redAccent,
        ),
        onTap: () async => await controller.deleteById(task.id),
      ),
      trailing: Checkbox(
        value: task.isDone,
        shape: const CircleBorder(),
        onChanged: (bool? newValue) async => await controller.edisIsDone(
          newValue!,
          task.id,
        ),
      ),
      onTap: () async {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Edit item'),
            content: TextFormField(
              onChanged: (String value) =>
                  controller.taskDescriptionController.text = value,
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(context, 'Cancel'),
              ),
              TextButton(
                child: const Text('OK'),
                onPressed: () async {
                  Navigator.pop(context, 'OK');

                  await controller.editDescription(
                    controller.taskDescriptionController.text,
                    task.id,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
