import '../entities/record_entity.dart';

abstract class RecordState {}

class RecordInitialState extends RecordState {}

class RecordLoadingState extends RecordState {
  final String label;

  RecordLoadingState({
    required this.label,
  });
}

class RecordSuccessState extends RecordState {
  final List<RecordReadAllEntity> payload;

  RecordSuccessState({
    required this.payload,
  });
}

class RecordPayloadInserted extends RecordState {
  final bool isInserted;
  RecordPayloadInserted({
    required this.isInserted,
  });
}

class RecordErrorState extends RecordState {
  final String errorMessage;

  RecordErrorState({
    required this.errorMessage,
  });
}
