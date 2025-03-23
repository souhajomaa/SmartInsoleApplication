import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'footpressure_state.dart';

class InsoleCubit extends Cubit<InsoleState> {
  final DatabaseReference databaseReference;

  InsoleCubit(this.databaseReference) : super(InsoleInitial());

  static InsoleCubit get(BuildContext context) => BlocProvider.of(context);

  void fetchFSRValues() async {
    emit(InsoleLoading());
    try {
      databaseReference.child('FSR').onValue.listen((event) {
        if (event.snapshot.value != null) {
          final data = event.snapshot.value as Map<dynamic, dynamic>;
          final fsrValues = List<double>.filled(8, 0.0);

          for (int i = 0; i < 8; i++) {
            final value = data['FSR${i + 1}'];
            fsrValues[i] = value is double ? value : double.parse(value.toString());
          }

          emit(InsoleLoaded(fsrValues));
        } else {
          emit(InsoleError("No data available"));
        }
      });
    } catch (e) {
      emit(InsoleError(e.toString()));
    }
  }

  int calculatePressure(double fsrValue) {
    int minOhms = 10;
    int maxOhms = 1000;
    int pressure = ((fsrValue - minOhms) / (maxOhms - minOhms) * 255).toInt();
    return pressure.clamp(0, 255);
  }

  Color getColorFromPressure(double fsrValue) {
    int intValue = fsrValue.toInt();
    if (intValue < 400) {
      return Colors.blue;
    } else if (intValue < 800) {
      return Colors.yellow;
    } else if (intValue < 1200) {
      return Colors.red;
    } else {
      return Colors.black;
    }
  }
}
