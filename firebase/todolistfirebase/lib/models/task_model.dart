import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String code;
  final String description;
  final bool isDone;
  final Timestamp createdAt;

  static const collectionName = 'tasks';

  static const codeFieldName = 'code';
  static const descriptionFieldName = 'description';
  static const isDoneFieldName = 'isDone';
  static const createdAtFieldName = 'createdAt';

  TaskModel({
    required this.code,
    required this.description,
    required this.isDone,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      codeFieldName: code,
      descriptionFieldName: description,
      isDoneFieldName: isDone,
      createdAtFieldName: createdAt,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      code: map[codeFieldName] ?? '',
      description: map[descriptionFieldName] ?? '',
      isDone: map[isDoneFieldName] ?? false,
      createdAt: map[createdAtFieldName] ?? Timestamp.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TaskModel(code: $code, description: $description, isDone: $isDone, createdAt: $createdAt)';
  }
}
