class TaskModel {
  int? _id = 0;
  String? _description;
  bool _isDone = false;
  int _createdAt = DateTime.now().millisecondsSinceEpoch;
  int? _updatedAt;

  TaskModel.empty();

  TaskModel({
    int? id,
    required String? description,
    required bool isDone,
    required int createdAt,
    required int? updatedAt,
  }) {
    _id = id;
    _description = description;
    _isDone = isDone;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  int get id => _id ?? 0;
  // set id(int id) => _id = id;
  String get description => _description ?? "";
  set description(String description) => _description = description;

  bool get isDone => _isDone;
  set isDone(bool isDone) => _isDone = isDone;
  int get createdAt => _createdAt;
  // set createdAt(int createdAt) => _createdAt = createdAt;
  int get updatedAt => _updatedAt ?? 0; // TODO: Change to 1970 epoch time.
  // set updatedAt(int updatedAt) => _updatedAt = updatedAt;

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as int,
      description: json['description'] as String?,
      isDone: json['isDone'] as bool,
      createdAt: json['createdAt'] as int,
      updatedAt: json['updatedAt'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['description'] = _description;
    data['isDone'] = _isDone;
    data['createdAt'] = _createdAt;
    data['updatedAt'] = _updatedAt;
    return data;
  }

  // A function that converts a response body into a List<Task>.
  // List<Task> parseTasks(String responseBody) {
  //   final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  //   return parsed.map<Task>((json) => Task.fromJson(json)).toList();
  // }

  @override
  String toString() {
    return 'Task(_id: $_id, _description: $_description, _isDone: $_isDone, _createdAt: $_createdAt, _updatedAt: $_updatedAt)';
  }
}
