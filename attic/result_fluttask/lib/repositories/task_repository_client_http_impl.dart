import 'package:fluttask/failures/tasks_failures.dart';
import 'package:fluttask/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert' as convert;

import 'package:fluttask/exceptions/result.dart';

import 'package:fluttask/repositories/i_task_repository.dart';

const String _baseUrl = 'http://0.0.0.0:3000/tasks';

class TaskRepositoryClientHttpImpl
    implements ITaskRepository<Task, TaskInsert> {
  var client = http.Client();

  @override
  Future<Result<List<Task>>> readAll() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );

    var url = Uri.parse(_baseUrl);

    try {
      var response = await client.get(
        url,
        headers: {
          "Content-Type": "application/json; charset=utf-8",
        },
      );

      if (response.statusCode == 404) {
        var exception =
            NotFoundTaskFailure(msgError: "Not found: ${response.statusCode}");
        return Error(exception);
      } else {
        var responseTasks = convert.jsonDecode(response.body) as List<dynamic>;
        var result = responseTasks.map((e) => Task.fromMap(e)).toList();
        return Success(result);
      }
    } on Exception catch (e, s) {
      debugPrint(s.toString());
      debugPrint(e.toString());
    }

    return Success([]);
  }

  @override
  Future<Result<void>> deleteOne(int identifier) async {
    try {
      final url = _baseUrl + "/$identifier";
      final finalUrl = Uri.parse(url);
      await client.delete(finalUrl);

      // var responseTasks = convert.jsonDecode(response.body) as Task;
      // ignore: void_checks
      return Success({});
    } on Exception catch (e, s) {
      debugPrint(s.toString());
      return Error(e);
    } finally {
      client.close();
    }
  }

  @override
  Future<Result<Task>> insertOne(TaskInsert data) async {
    await Future.delayed(
      const Duration(seconds: 3),
    );

    try {
      var url = Uri.parse(_baseUrl);
      await client.post(
        url,
        headers: {
          "Content-Type": "application/json; charset=utf-8",
        },
        body: convert.jsonEncode(
          <String, dynamic>{
            "description": data.description,
            "isDone": data.isDone,
            "createdAt": data.createdAt.millisecondsSinceEpoch,
            "updatedAt": null
          },
        ),
      );

      return Success(Task.mock());
    } on Exception catch (e, s) {
      debugPrint(s.toString());
      return Error(e);
    } finally {
      client.close();
    }
  }

  @override
  Future<Result<void>> updateDescription(
      TaskUpdateDescription task, int identifier) async {
    await Future.delayed(
      const Duration(seconds: 3),
    );

    try {
      final url = _baseUrl + "/$identifier";
      final finalUrl = Uri.parse(url);

      await client.patch(
        finalUrl,
        headers: {
          "Content-Type": "application/json; charset=utf-8",
        },
        body: convert.jsonEncode(
          <String, dynamic>{
            "description": task.newValue,
            "updatedAt": task.updatedAt.millisecondsSinceEpoch
          },
        ),
      );

      // ignore: void_checks
      return Success({});
    } on Exception catch (e, s) {
      debugPrint(s.toString());
      return Error(e);
    } finally {
      client.close();
    }
  }

  @override
  Future<Result<void>> updateIsDone(
      TaskUpdateIsDone taskIsDone, int identifier) async {
    await Future.delayed(
      const Duration(seconds: 3),
    );

    try {
      final url = _baseUrl + "/$identifier";
      final finalUrl = Uri.parse(url);

      await client.patch(
        finalUrl,
        headers: {
          "Content-Type": "application/json; charset=utf-8",
        },
        body: convert.jsonEncode(
          <String, dynamic>{
            "isDone": taskIsDone.newValue,
            "updatedAt": taskIsDone.updatedAt.millisecondsSinceEpoch
          },
        ),
      );

      // ignore: void_checks
      return Success({});
    } on Exception catch (e, s) {
      debugPrint(s.toString());
      return Error(e);
    } finally {
      client.close();
    }
  }
}
