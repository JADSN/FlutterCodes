import 'package:dartz/dartz.dart';
import 'package:taskermobx/exceptions/tasks_error.dart';

abstract class IHttpService<T> {
  Future<Either<TasksFailure, List<T>>> get(String url);
  Future<Either<TasksFailure, T>> post(String url, T data);
  Future<Either<TasksFailure, int>> delete(String url, int id);
  Future<Either<TasksFailure, T>> update(String url, int id, T data);
}
