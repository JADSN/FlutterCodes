import 'package:fluttask/exceptions/result.dart';
import 'package:fluttask/models/task_model.dart';
import 'package:fluttask/repositories/i_task_repository.dart';
import 'package:flutter/material.dart';

typedef TaskModelList = List<Task>;

class HomeController {
  late TextEditingController taskDescriptionController;

  late final ITaskRepository<Task, TaskInsert> _repository;
  ValueNotifier<Future<Result<List<Task>>>> listTaskNotifier =
      ValueNotifier(Future.value(Success(<Task>[])));

  get listTask => listTaskNotifier.value;

  HomeController(this._repository) {
    listTaskNotifier.value = _repository.readAll();
  }

  Future<Result<List<Task>>> readAll() async {
    var result = await _repository.readAll();

    return result;
  }

  Future<Result<void>> insertOne(String description) async {
    var taskToInsert = TaskInsert(
      description: description,
      isDone: false,
      createdAt: DateTime.now(),
    );

    var result = await _repository.insertOne(taskToInsert);
    listTaskNotifier.value = _repository.readAll();

    return result;
  }

  Future<Result<void>> deleteById(int identifier) async {
    var result = await _repository.deleteOne(identifier);

    listTaskNotifier.value = _repository.readAll();

    return result;
  }

  Future<Result<void>> editDescription(
      String newDescription, int identifier) async {
    var taskToUpdate = TaskUpdateDescription(
      newValue: newDescription,
      updatedAt: DateTime.now(),
    );

    var result = await _repository.updateDescription(taskToUpdate, identifier);

    listTaskNotifier.value = _repository.readAll();

    return result;
  }

  Future<Result<void>> edisIsDone(bool newIsDone, int identifier) async {
    var taskToUpdate = TaskUpdateIsDone(
      newValue: newIsDone,
      updatedAt: DateTime.now(),
    );

    var result = await _repository.updateIsDone(taskToUpdate, identifier);

    listTaskNotifier.value = _repository.readAll();

    return result;
  }
}
