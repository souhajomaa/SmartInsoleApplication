import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'add_player_state.dart';



class PlayerCubit extends Cubit<PlayerState> {
  PlayerCubit() : super(PlayerInitial());

  Future<void> fetchPlayers() async {
    emit(PlayerLoading());
    try {
      final snapshot = await FirebaseFirestore.instance.collection('players').get();
      final players = snapshot.docs.map((doc) => doc.data()).toList();
      emit(PlayerLoaded(players));
    } catch (e) {
      emit(PlayerError(e.toString()));
    }
  }

  Future<void> addPlayer(Map<String, dynamic> playerInfo) async {
    try {
      final docRef = await FirebaseFirestore.instance.collection('players').add(playerInfo);
      playerInfo['Id'] = docRef.id;
      await docRef.update({'Id': docRef.id});
      fetchPlayers();
    } catch (e) {
      emit(PlayerError(e.toString()));
    }
  }

  Future<void> updatePlayer(String id, Map<String, dynamic> playerInfo) async {
    try {
      await FirebaseFirestore.instance.collection('players').doc(id).update(playerInfo);
      fetchPlayers();
    } catch (e) {
      emit(PlayerError(e.toString()));
    }
  }

  Future<void> deletePlayer(String id) async {
    try {
      await FirebaseFirestore.instance.collection('players').doc(id).delete();
      fetchPlayers();
    } catch (e) {
      emit(PlayerError(e.toString()));
    }
  }
}
