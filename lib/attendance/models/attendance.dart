import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Attendance extends Equatable {
  const Attendance({
    required this.notAvailableFrom,
    required this.notAvailableUntil,
    required this.displayName,
  });

  /// Creates a Attendance from Json map
  factory Attendance.fromJson(Map<String, dynamic> json, String displayName) => Attendance(
        displayName: displayName,
        notAvailableFrom: (json['notAvailableFrom'] as int?) == null
            ? null
            : Timestamp.fromMillisecondsSinceEpoch(json['notAvailableFrom'] as int),
        notAvailableUntil: (json['notAvailableUntil'] as int?) == null
            ? null
            : Timestamp.fromMillisecondsSinceEpoch(json['notAvailableUntil'] as int),
      );

  final Timestamp? notAvailableFrom;
  final Timestamp? notAvailableUntil;
  final String displayName;

  @override
  List<Object?> get props => [notAvailableFrom, notAvailableUntil, displayName];

  /// Creates a Json map from a Attendance
  Map<String, dynamic> toJson() => <String, dynamic>{
        'notAvailableFrom': notAvailableFrom?.millisecondsSinceEpoch,
        'notAvailableUntil': notAvailableUntil?.millisecondsSinceEpoch,
      };
}
