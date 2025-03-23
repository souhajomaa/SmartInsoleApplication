import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterManager {
  Future<void> addUserDetails(String username, String email) async {
    await FirebaseFirestore.instance.collection('users').add({
      'username': username,
      'email': email,
    });
  }

  Future<void> signUpUser(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw e.code;
    }
  }
  Future<void> getUserDetails(String username, String email) async {
    await FirebaseFirestore.instance.collection('users').add({
      'username': username,
      'email': email,
    });
  }
   
}
