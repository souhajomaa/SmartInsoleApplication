

abstract class ApiSummaryState {}

class ApiSummaryInitial extends ApiSummaryState {}

class JsonSummaryLoading extends ApiSummaryState {}

class JsonSummaryLoaded extends ApiSummaryState {
  final dynamic data;
  JsonSummaryLoaded(this.data);
}

class JsonSummaryError extends ApiSummaryState {
  final String message;
  JsonSummaryError(this.message);
}
