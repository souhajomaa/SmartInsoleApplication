abstract class ApiSheetCadenceState {}

class ApiCadenceInitial extends ApiSheetCadenceState {}

class JsonCadenceLoading extends ApiSheetCadenceState {}

class JsonCadenceLoaded extends ApiSheetCadenceState {
  final List<Map<String, dynamic>> cadenceData;
  final List<String> time;

  JsonCadenceLoaded(this.cadenceData, this.time);
}

class JsonCadenceError extends ApiSheetCadenceState {
  final String message;
  JsonCadenceError(this.message);
}
