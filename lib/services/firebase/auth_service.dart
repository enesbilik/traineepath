import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trainee_path/models/user_model.dart';

class AuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  Future<UserCredential?> signIn(String _email, String _password) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: _email, password: _password);

    return userCredential;
  }

  static Future<UserCredential?> register(
      UserModel _user, String _password) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: _user.mail, password: _password);

    if (userCredential.user != null) {
      _user.userId = userCredential.user!.uid;
      await _firebaseFirestore
          .collection("USERS")
          .doc(_user.userId)
          .set(_user.toMap());
    }

    return userCredential;
  }

  static Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  static Future<void> passwordReset(String _email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: _email);
  }
}
