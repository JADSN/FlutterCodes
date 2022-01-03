class TaskModel {
  final List<Task> tasks;

  TaskModel({
    required this.tasks,
  });
}

class Task {
  final int id;
  final String description;
  final bool isDone;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Task({
    required this.id,
    required this.description,
    required this.isDone,
    required this.createdAt,
    this.updatedAt,
  });

  factory Task.fromMap(Map<String, dynamic> json) => Task(
        id: json["id"],
        description: json["description"],
        isDone: json["isDone"],
        createdAt: DateTime.fromMillisecondsSinceEpoch(json["createdAt"]),
        updatedAt: (json["updatedAt"] != null)
            ? DateTime.fromMillisecondsSinceEpoch(json["updatedAt"])
            : null,
      );

  factory Task.mock() => Task(
        id: 0,
        description: "",
        isDone: false,
        createdAt: DateTime.now(),
      );
}

class TaskInsert {
  final String description;
  final bool isDone;
  final DateTime createdAt;
  final DateTime? updatedAt;

  TaskInsert({
    required this.description,
    required this.isDone,
    required this.createdAt,
    this.updatedAt,
  });

  factory TaskInsert.fromMap(Map<String, dynamic> json) => TaskInsert(
        description: json["description"],
        isDone: json["isDone"],
        createdAt: DateTime.fromMillisecondsSinceEpoch(json["createdAt"]),
        updatedAt: (json["updatedAt"] != null)
            ? DateTime.fromMillisecondsSinceEpoch(json["updatedAt"])
            : null,
      );
}

class TaskUpdateDescription {
  final String newValue;
  final DateTime updatedAt;

  TaskUpdateDescription({
    required this.newValue,
    required this.updatedAt,
  });
}

class TaskUpdateIsDone {
  final bool newValue;
  final DateTime updatedAt;

  TaskUpdateIsDone({
    required this.newValue,
    required this.updatedAt,
  });
}
