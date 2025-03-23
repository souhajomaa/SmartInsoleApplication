import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'header_trainer_state.dart';

class HeaderTrainerCubit extends Cubit<HeaderTrainerState> {
  HeaderTrainerCubit() : super(HeaderTrainerInitial());

  Future<void> getUsername(String email) async {
    emit(HeaderTrainerLoading());

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final username = snapshot.docs.first['username'];
        emit(HeaderTrainerLoaded(username));
      } else {
        emit(HeaderTrainerError('User not found'));
      }
    } catch (e) {
      emit(HeaderTrainerError('Error getting username: $e'));
    }
  }
}
