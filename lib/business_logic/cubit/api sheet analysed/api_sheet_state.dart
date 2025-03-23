part of 'api_sheet_cubit.dart';

abstract class ApiState {}

class ApiInitial extends ApiState {}

class JsonLoading extends ApiState {}

class JsonLoaded extends ApiState {
  final dynamic data;
  JsonLoaded(this.data);
}

class JsonError extends ApiState {
  final String message;
  JsonError(this.message);
}
