import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'foot_pressure_left_state.dart';

class InsoleLeftCubit extends Cubit<InsoleLeftState> {
  final DatabaseReference databaseReference1;

  InsoleLeftCubit(this.databaseReference1) : super(InsoleLeftInitial());

  static InsoleLeftCubit get(BuildContext context) => BlocProvider.of(context);

  void fetchFSRLeftValues() async {
    emit(InsoleLeftLoading());
    try {
      databaseReference1.child('FSRGAUCHE').onValue.listen((event) {
        if (event.snapshot.value != null) {
          final data = Map<String, dynamic>.from(event.snapshot.value as Map);
          final fsrLeftValues = List<int>.filled(8, 0);

          for (int i = 9; i <= 16; i++) {
            final value = data['FSR$i'];
            fsrLeftValues[i - 9] = value is int ? value : int.parse(value.toString());
          }

          emit(InsoleLeftLoaded(fsrLeftValues));
        } else {
          emit(InsoleLeftError("No data available"));
        }
      });
    } catch (e) {
      emit(InsoleLeftError(e.toString()));
    }
  }

  int calculatePressure(int fsrValue) {
    int minOhms = 100;
    int maxOhms = 1000;
    int pressure = ((fsrValue - minOhms) / (maxOhms - minOhms) * 255).toInt();
    return pressure.clamp(0, 255);
  }

  Color getColorFromPressure(int fsrValue) {
    if (fsrValue < 400) {
      return Colors.blue;
   
    } else if (fsrValue < 800) {
 return Colors.yellow;
     } else if (fsrValue < 1200) {
      return Colors.red;
    } else {
      return Colors.black;
    }
  }
}
