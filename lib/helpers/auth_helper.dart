import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  static Future<User?> login(String email, String password) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch (e) {
      print("AuthHelper login error: ${e.toString()}");
      return null;
    }
  }
}
