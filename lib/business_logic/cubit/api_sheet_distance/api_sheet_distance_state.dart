abstract class ApiSheetDistanceState {}

class ApiDistanceInitial extends ApiSheetDistanceState {}

class JsonDistanceLoading extends ApiSheetDistanceState {}

class JsonDistanceLoaded extends ApiSheetDistanceState {
  final List<Map<String, dynamic>> distanceData;
  final List<String> time;

  JsonDistanceLoaded(this.distanceData, this.time);
}

class JsonDistanceError extends ApiSheetDistanceState {
  final String message;
  JsonDistanceError(this.message);
}
