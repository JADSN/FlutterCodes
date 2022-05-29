// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:magoney_frontend/modules/receipt_module/entities/receipt_entity.dart';

abstract class ReceiptState {}

class ReceiptInitialState extends ReceiptState {}

class ReceiptLoadingState extends ReceiptState {
  final String label;

  ReceiptLoadingState({
    required this.label,
  });
}

class ReceiptSuccessState extends ReceiptState {
  final List<ReceiptReadAllEntity> payload;

  ReceiptSuccessState({
    required this.payload,
  });
}

class ReceiptSuccessReadOneState extends ReceiptState {
  final ReceiptReadOneEntity payload;

  ReceiptSuccessReadOneState({
    required this.payload,
  });
}

class ReceiptPayloadInserted extends ReceiptState {
  final bool isInserted;
  ReceiptPayloadInserted({
    required this.isInserted,
  });
}

class ReceiptErrorState extends ReceiptState {
  final String errorMessage;

  ReceiptErrorState({
    required this.errorMessage,
  });
}
