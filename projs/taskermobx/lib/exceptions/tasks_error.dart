class TasksFailure implements Exception {}

class FetchTasksFailure extends TasksFailure {
  final String msgError;
  FetchTasksFailure({required this.msgError});
}

class NotFoundTaskFailure extends TasksFailure {
  final String msgError;
  NotFoundTaskFailure({required this.msgError});
}

class ServerFailure extends TasksFailure {
  final String msgError;
  ServerFailure({required this.msgError});
}
