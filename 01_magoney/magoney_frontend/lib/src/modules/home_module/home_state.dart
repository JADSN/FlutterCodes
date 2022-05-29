// ignore_for_file: public_member_api_docs, sort_constructors_first
class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {
  String label;

  HomeLoadingState({
    required this.label,
  });
}

class HomeSuccessState extends HomeState {
  int payload;

  HomeSuccessState({
    required this.payload,
  });
}

class HomeErrorState extends HomeState {
  String errorMessage;

  HomeErrorState({
    required this.errorMessage,
  });
}
