import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:taskermobx/exceptions/tasks_error.dart';
import 'package:taskermobx/models/task_model.dart';
import 'package:taskermobx/services/task_service.dart';

import 'package:http/http.dart' as http;

class TaskRespository implements IHttpService<TaskModel> {
  @override
  Future<Either<TasksFailure, List<TaskModel>>> get(String url) async {
    try {
      await Future.delayed(const Duration(milliseconds: 3000));

      var client = http.Client();

      final response = await client.get(Uri.parse(url));

      //  * Converts a response body into a List<T>.
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();

      final parsedResult =
          parsed.map<TaskModel>((json) => TaskModel.fromJson(json)).toList();

      // TODO: User compute to avoid app freezes.
      // https://flutter.dev/docs/cookbook/networking/background-parsing
      // return right([]);
      return right(parsedResult);
    } on SocketException {
      print("SocketException");
      throw FetchTasksFailure(msgError: 'No Internet connection');
    } on Exception catch (e) {
      print("Exception - get(): ${e.toString()}");

      if (e.toString().startsWith("XMLHttpRequest")) {
        return left(ServerFailure(msgError: "Server down."));
      }

      return left(FetchTasksFailure(msgError: e.toString()));
    }
  }

  @override
  Future<Either<TasksFailure, TaskModel>> post(
      String url, TaskModel data) async {
    try {
      Either<TasksFailure, TaskModel> taskModel = right(TaskModel.empty());
      await Future.delayed(const Duration(milliseconds: 3000));
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'description': data.description,
          'isDone': data.isDone,
          'createdAt': data.createdAt,
          'updatedAt': data.updatedAt,
        }),
      );

      if (response.statusCode == 201) {
        taskModel = right(TaskModel.fromJson(jsonDecode(response.body)));
      }

      return taskModel;
    } on Exception catch (e) {
      print("Exception on post() taskModel: ${{e.toString()}}");
      return left(FetchTasksFailure(msgError: e.toString()));
    }
  }

  @override
  Future<Either<TasksFailure, int>> delete(String url, int id) async {
    await Future.delayed(const Duration(milliseconds: 3000));
    var paramId = "/$id";
    var resultUrl = url + paramId;

    try {
      Either<TasksFailure, int> result = right(0);
      final response = await http.delete(
        Uri.parse(resultUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        result = right(id);
      }

      if (response.statusCode == 404) {
        result =
            left(NotFoundTaskFailure(msgError: response.reasonPhrase ?? ""));
      }

      return result;
    } on Exception catch (e) {
      print("Exception on delete() taskModel: ${{e.toString()}}");
      return left(FetchTasksFailure(msgError: e.toString()));
    }
  }

  @override
  Future<Either<TasksFailure, TaskModel>> update(
      String url, int id, TaskModel data) async {
    await Future.delayed(const Duration(milliseconds: 3000));

    var paramId = "/$id";
    var resultUrl = url + paramId;

    try {
      Either<TasksFailure, TaskModel> taskModel = right(TaskModel.empty());
      final response = await http.patch(
        Uri.parse(resultUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            'description': data.description,
            'isDone': data.isDone,
            'updatedAt': data.updatedAt
          },
        ),
      );

      if (response.statusCode == 200) {
        taskModel = right(TaskModel.fromJson(jsonDecode(response.body)));
      }

      if (response.statusCode == 404) {
        taskModel =
            left(NotFoundTaskFailure(msgError: response.reasonPhrase ?? ""));
      }

      return taskModel;
    } on Exception catch (e) {
      print("Exception on update() taskModel: ${{e.toString()}}");
      return left(FetchTasksFailure(msgError: e.toString()));
    }
  }
}
