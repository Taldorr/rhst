// coverage:ignore-file

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/attendance.dart';

class AttendanceRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<List<Attendance>> getAllAttendances() => _firestore
      .collection("attendance")
      .get()
      .then((snap) => snap.docs.map((d) => Attendance.fromJson(d.data())).toList());

  Future<void> updateAttendance(String userId, int? notAvailableUntil) => _firestore
      .doc("attendance/$userId")
      .set({"notAvailableUntil": notAvailableUntil}, SetOptions(merge: true));
}
