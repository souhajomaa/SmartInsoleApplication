import 'package:firebase_auth/firebase_auth.dart';

class LoginManager {
  Future<void> signInUser(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw e.code;
    }
  }
}
