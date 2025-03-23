import 'package:cloud_firestore/cloud_firestore.dart';

class HeaderManager {
  Future<String?> getUsername(String email) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first['username'];
      } else {
        return null;
      }
    } catch (e) {
      
      print('Error getting username: $e');
      return null;
    }
  }
}
