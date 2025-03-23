import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_database/firebase_database.dart';

import 'activity_states.dart';

class ActivityCubit extends Cubit<ActivityState> {
  ActivityCubit() : super(ActivityInitial());
  static ActivityCubit get(context) => BlocProvider.of(context);

  void fetchData() async {
    emit(ActivityLoading());
    try {
      FirebaseDatabase.instance.ref().child('ESP').onValue.listen((event) {
        if (event.snapshot.value != null) {
          final data = Map<String, dynamic>.from(event.snapshot.value as Map);
          emit(ActivityLoaded(data));
        } else {
          emit(ActivityError("No data available"));
        }
      });
    } catch (e) {
      emit(ActivityError(e.toString()));
    }
  }
}
