import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class InsoleState extends Equatable {
  @override
  List<Object> get props => [];
}

class InsoleInitial extends InsoleState {}
class InsoleLoading extends  InsoleState{}

class InsoleLoaded extends InsoleState {
  final List<double> fsrValues;

  InsoleLoaded(this.fsrValues);

  @override
  List<Object> get props => [fsrValues];
}

class InsoleError extends InsoleState {
  final String message;

  InsoleError(this.message);
}