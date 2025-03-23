import 'package:cloud_firestore/cloud_firestore.dart';

class DatabasePlayers {
  Future addPlayersDetails(
      Map<String, dynamic> playerInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("players")
        .doc(id)
        .set(playerInfoMap);
  }

  Future<bool> checkDataExists(
      {required String nameSurname,
      required String email,
      required String age,
      required weight,
      required String size,
      required String strongfoot}) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("players")
        .where("Name & Surname", isEqualTo: nameSurname)
        .where("E-mail", isEqualTo: email)
        .where("Age", isEqualTo: age)
        .where("Weight", isEqualTo: weight)
        .where("Size", isEqualTo: size)
        .where("Strong foot", isEqualTo: strongfoot)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  Future<Stream<QuerySnapshot>> getPlayersDetails() async {
    return await FirebaseFirestore.instance.collection("players").snapshots();
  }

  Future updatePlayerDetail(String id, Map<String, dynamic> updateInfo) async {
  return await FirebaseFirestore.instance
        .collection("players")
        .doc(id)
        .update(updateInfo);
  }
  Future deletePlayerDetail(String id) async {
    try {
      await FirebaseFirestore.instance.collection("players").doc(id).delete();
    } catch (error) {
      print("Error deleting player: $error");
    }
  }
}
