abstract class ApiSheetStrideLengthState {}

class ApiStrideLengthInitial extends ApiSheetStrideLengthState {}

class JsonStrideLengthLoading extends ApiSheetStrideLengthState {}

class JsonStrideLengthLoaded extends ApiSheetStrideLengthState {
  final List<Map<String, dynamic>> strideLengthData;
  final List<String> time;

  JsonStrideLengthLoaded(this.strideLengthData, this.time);
}

class JsonStrideLengthError extends ApiSheetStrideLengthState {
  final String message;
  JsonStrideLengthError(this.message);
}
