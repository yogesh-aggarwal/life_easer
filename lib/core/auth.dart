import 'package:firebase_auth/firebase_auth.dart';
import 'package:life_easer/core/firebase.dart';

Future<UserCredential> signInWithEmailAndPassword(
    String email, String password) async {
  return await auth.signInWithEmailAndPassword(
      email: email, password: password);
}
