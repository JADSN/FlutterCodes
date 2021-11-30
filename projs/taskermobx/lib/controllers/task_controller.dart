import 'package:dartz/dartz.dart';
import 'package:taskermobx/exceptions/tasks_error.dart';
import 'package:taskermobx/models/task_model.dart';
import 'package:taskermobx/repositories/task_repository.dart';

class TaskController {
  final _repository = TaskRespository();

  Future<Either<TasksFailure, List<TaskModel>>> readAllTasks() async {
    return _repository.get("http://0.0.0.0:3000/tasks");
  }

  Future<Either<TasksFailure, TaskModel>> createOneTask(TaskModel body) async {
    return _repository.post("http://0.0.0.0:3000/tasks", body);
  }

  Future<Either<TasksFailure, int>> deleteOneTask(int id) async {
    return _repository.delete("http://0.0.0.0:3000/tasks", id);
  }

  Future updateOneTask(int id, TaskModel bodyData) async {
    return _repository.update("http://0.0.0.0:3000/tasks", id, bodyData);
  }
}
