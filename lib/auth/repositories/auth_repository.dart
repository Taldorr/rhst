// coverage:ignore-file

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_settings.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Stream<User?> get $currentUser => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmail(String email, String password) =>
      _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

  Future<void> signOut() => _firebaseAuth.signOut();

  Future<void> resetPassword(String email) => _firebaseAuth.sendPasswordResetEmail(email: email);

  Future<UserSettings> loadSettings(String userId) =>
      _firestore.doc("humans/$userId").get().then((snap) => UserSettings.fromJson(snap.data()!));

  Future<void> updateSettings(String userId, UserSettings settings) =>
      _firestore.doc("humans/$userId").update(settings.toJson());
}
