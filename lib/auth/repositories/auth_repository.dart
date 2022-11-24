// coverage:ignore-file

import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get $currentUser => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmail(String email, String password) =>
      _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

  Future<void> signOut() => _firebaseAuth.signOut();

  Future<void> resetPassword(String email) => _firebaseAuth.sendPasswordResetEmail(email: email);
}
