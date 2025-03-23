abstract class ActivityState {}

class ActivityInitial extends ActivityState {}

class ActivityLoading extends ActivityState {}

class ActivityLoaded extends ActivityState {
  final Map<String, dynamic> data;

  ActivityLoaded(this.data);
}

class ActivityError extends ActivityState {
  final String message;

  ActivityError(this.message);
}
