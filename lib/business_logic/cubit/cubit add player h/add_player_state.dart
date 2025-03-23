import 'package:meta/meta.dart';

@immutable
abstract class PlayerState {}

class PlayerInitial extends PlayerState {}

class PlayerLoading extends PlayerState {}

class PlayerLoaded extends PlayerState {
  final List<Map<String, dynamic>> players;
  PlayerLoaded(this.players);
}

class PlayerError extends PlayerState {
  final String message;
  PlayerError(this.message);
}
