import 'package:flutter/material.dart';

import 'package:fluttask/component/task_list_item_component.dart';
import 'package:fluttask/models/task_model.dart';
import 'package:fluttask/pages/home/home_controller.dart';

class HomeOk extends StatelessWidget {
  final HomeController controller;
  final List<Task> tasks;

  const HomeOk({
    Key? key,
    required this.controller,
    required this.tasks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? const Center(
            child: Text(
              "NO ITEMS",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (BuildContext context, int index) {
              var taskItem = tasks.elementAt(index);

              return TaskListItemComponent(
                controller: controller,
                task: taskItem,
              );
            },
          );
  }
}
