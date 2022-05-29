// ignore_for_file: public_member_api_docs, sort_constructors_first
class FcPapersAccountsState {}

class FcPapersAccountsInitialState extends FcPapersAccountsState {}

class FcPapersAccountsLoadingState extends FcPapersAccountsState {
  String label;

  FcPapersAccountsLoadingState({
    required this.label,
  });
}

class FcPapersAccountsSuccessState extends FcPapersAccountsState {
  List<String> payload;

  FcPapersAccountsSuccessState({
    required this.payload,
  });
}

class FcPapersAccountsErrorState extends FcPapersAccountsState {
  String errorMessage;

  FcPapersAccountsErrorState({
    required this.errorMessage,
  });
}
