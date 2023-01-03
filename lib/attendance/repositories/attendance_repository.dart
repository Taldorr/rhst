// coverage:ignore-file

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/attendance.dart';

class AttendanceRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<List<Attendance>> getAllAttendances() =>
      _firestore.collection("humans").get().then((snap) => snap.docs
          .map((d) => Attendance.fromJson(d.data(), _concatDisplayName(d.data())))
          .toList());

  Future<void> updateAttendance(String userId, int? notAvailableFrom, int? notAvailableUntil) =>
      _firestore.doc("humans/$userId").set({
        "notAvailableFrom": notAvailableFrom,
        "notAvailableUntil": notAvailableUntil,
      }, SetOptions(merge: true));
}

String _concatDisplayName(Map<String, dynamic> raw) {
  assert(raw["firstName"] != null && raw["lastName"] != null);
  return "${raw["firstName"]} ${(raw["lastName"] as String)[0]}.";
}
