import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class InsoleLeftState extends Equatable {
  @override
  List<Object> get props => [];
}

class InsoleLeftInitial extends InsoleLeftState {}
class InsoleLeftLoading extends  InsoleLeftState{}

class InsoleLeftLoaded extends InsoleLeftState {
  final List<int> fsrLeftValues;

  InsoleLeftLoaded(this.fsrLeftValues);

  @override
  List<Object> get props => [fsrLeftValues];
}
class InsoleLeftError extends InsoleLeftState {
  final String message;

  InsoleLeftError(this.message);
}