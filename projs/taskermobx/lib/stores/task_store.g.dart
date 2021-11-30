// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TaskStore on _TaskStore, Store {
  final _$descriptionAtom = Atom(name: '_TaskStore.description');

  @override
  String get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  final _$isDoneAtom = Atom(name: '_TaskStore.isDone');

  @override
  bool get isDone {
    _$isDoneAtom.reportRead();
    return super.isDone;
  }

  @override
  set isDone(bool value) {
    _$isDoneAtom.reportWrite(value, super.isDone, () {
      super.isDone = value;
    });
  }

  final _$isProcessingAtom = Atom(name: '_TaskStore.isProcessing');

  @override
  bool get isProcessing {
    _$isProcessingAtom.reportRead();
    return super.isProcessing;
  }

  @override
  set isProcessing(bool value) {
    _$isProcessingAtom.reportWrite(value, super.isProcessing, () {
      super.isProcessing = value;
    });
  }

  final _$crudStateAtom = Atom(name: '_TaskStore.crudState');

  @override
  CrudState get crudState {
    _$crudStateAtom.reportRead();
    return super.crudState;
  }

  @override
  set crudState(CrudState value) {
    _$crudStateAtom.reportWrite(value, super.crudState, () {
      super.crudState = value;
    });
  }

  final _$failureAtom = Atom(name: '_TaskStore.failure');

  @override
  Option<TasksFailure> get failure {
    _$failureAtom.reportRead();
    return super.failure;
  }

  @override
  set failure(Option<TasksFailure> value) {
    _$failureAtom.reportWrite(value, super.failure, () {
      super.failure = value;
    });
  }

  final _$listOfTasksAtom = Atom(name: '_TaskStore.listOfTasks');

  @override
  ObservableList<TaskModel> get listOfTasks {
    _$listOfTasksAtom.reportRead();
    return super.listOfTasks;
  }

  @override
  set listOfTasks(ObservableList<TaskModel> value) {
    _$listOfTasksAtom.reportWrite(value, super.listOfTasks, () {
      super.listOfTasks = value;
    });
  }

  final _$readAllTasksAsyncAction = AsyncAction('_TaskStore.readAllTasks');

  @override
  Future<void> readAllTasks() {
    return _$readAllTasksAsyncAction.run(() => super.readAllTasks());
  }

  final _$addToListAsyncAction = AsyncAction('_TaskStore.addToList');

  @override
  Future<void> addToList() {
    return _$addToListAsyncAction.run(() => super.addToList());
  }

  final _$removeTaskFromListAsyncAction =
      AsyncAction('_TaskStore.removeTaskFromList');

  @override
  Future<void> removeTaskFromList(int index) {
    return _$removeTaskFromListAsyncAction
        .run(() => super.removeTaskFromList(index));
  }

  final _$updateOneTaskAsyncAction = AsyncAction('_TaskStore.updateOneTask');

  @override
  Future<void> updateOneTask(int index) {
    return _$updateOneTaskAsyncAction.run(() => super.updateOneTask(index));
  }

  @override
  String toString() {
    return '''
description: ${description},
isDone: ${isDone},
isProcessing: ${isProcessing},
crudState: ${crudState},
failure: ${failure},
listOfTasks: ${listOfTasks}
    ''';
  }
}
