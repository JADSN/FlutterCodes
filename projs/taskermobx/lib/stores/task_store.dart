import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';

import 'package:taskermobx/controllers/task_controller.dart';
import 'package:taskermobx/exceptions/tasks_error.dart';
import 'package:taskermobx/models/task_model.dart';
import 'package:taskermobx/states/crud_state.dart';

part 'task_store.g.dart';

class TaskStore = _TaskStore with _$TaskStore;

abstract class _TaskStore with Store {
  final TaskController taskController = TaskController();

  @observable
  String description = "";

  @observable
  bool isDone = false;

  @observable
  bool isProcessing = false;

  @observable
  CrudState crudState = CrudState.nop;

  @observable
  Option<TasksFailure> failure = none();

  @observable
  ObservableList<TaskModel> listOfTasks = ObservableList.of([]);

  _TaskStore() {
    readAllTasks();

    // autorun((_) => print("DESCRIPTION: $description"));
  }

  @action
  Future<void> readAllTasks() async {
    isProcessing = true;
    crudState = CrudState.reading;

    var resultTasks = await taskController.readAllTasks();

    resultTasks.fold((failureResult) {
      failure = optionOf(failureResult);

      // * Fetch done
      isProcessing = false;
      crudState = CrudState.nop;
    }, (data) {
      // * Refresh list
      listOfTasks = ObservableList.of(data);
      // * Fetch done
      isProcessing = false;
      crudState = CrudState.nop;
    });
  }

  @action
  Future<void> addToList() async {
    var newTaskModel = TaskModel(
      description: description,
      isDone: isDone,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      updatedAt: null,
    );

    isProcessing = true;
    crudState = CrudState.creating;

    var resultTask = await taskController.createOneTask(newTaskModel);

    resultTask.fold((failureResult) => failure = optionOf(failureResult),
        (data) async {
      (await taskController.readAllTasks()).map((data) {
        // * Refresh list
        listOfTasks = ObservableList.of(data);

        // * Fetch done
        isProcessing = false;
        crudState = CrudState.nop;
      });
    });
  }

  @action
  Future<void> removeTaskFromList(int index) async {
    isProcessing = true;
    crudState = CrudState.deleting;

    int elementIdByIndex = listOfTasks.elementAt(index).id;
    var resultTask = await taskController.deleteOneTask(elementIdByIndex);

    resultTask.fold((failureResult) {
      failure = optionOf(failureResult);

      // * Fetch done
      isProcessing = false;
      crudState = CrudState.nop;
    }, (data) async {
      (await taskController.readAllTasks()).map((data) {
        // * Refresh list
        listOfTasks = ObservableList.of(data);

        // * Fetch done
        isProcessing = false;
        crudState = CrudState.nop;
      });
    });
  }

  @action
  Future<void> updateOneTask(int index) async {
    isProcessing = true;
    crudState = CrudState.updating;

    TaskModel taskToUpdate = TaskModel(
      description: description,
      isDone: false,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );

    int elementIdByIndex = listOfTasks.elementAt(index).id;
    var resultTask =
        await taskController.updateOneTask(elementIdByIndex, taskToUpdate);

    resultTask.fold((failureResult) {
      failure = optionOf(failureResult);

      // * Fetch done
      isProcessing = false;
      crudState = CrudState.nop;
    }, (data) async {
      (await taskController.readAllTasks()).map((data) {
        // * Refresh list
        listOfTasks = ObservableList.of(data);

        // * Fetch done
        isProcessing = false;
        crudState = CrudState.nop;
      });
    });
    // // * Refresh list
  }
}
