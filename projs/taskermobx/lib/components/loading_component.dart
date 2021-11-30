import 'package:flutter/material.dart';

import 'package:taskermobx/states/crud_state.dart';
import 'package:taskermobx/stores/task_store.dart';

class LoadingComponent extends StatefulWidget {
  final TaskStore taskStore;

  const LoadingComponent({
    Key? key,
    required this.taskStore,
  }) : super(key: key);

  @override
  _LoadingComponentState createState() => _LoadingComponentState();
}

class _LoadingComponentState extends State<LoadingComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            widget.taskStore.crudState.convToString().toUpperCase(),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
