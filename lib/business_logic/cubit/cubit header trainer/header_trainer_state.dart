import 'package:meta/meta.dart';

@immutable
abstract class HeaderTrainerState {}

class HeaderTrainerInitial extends HeaderTrainerState {}

class HeaderTrainerLoading extends HeaderTrainerState {}

class HeaderTrainerLoaded extends HeaderTrainerState {
  final String username;

  HeaderTrainerLoaded(this.username);
}

final class HeaderTrainerError extends HeaderTrainerState {
  final String message;
  HeaderTrainerError(this.message);
}
