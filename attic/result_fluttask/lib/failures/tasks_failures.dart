class TasksFailure implements Exception {}

class NotFoundTaskFailure extends TasksFailure {
  final String msgError;
  NotFoundTaskFailure({required this.msgError});
}
