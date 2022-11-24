import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Attendance extends Equatable {
  const Attendance({
    required this.displayName,
    required this.notAvailableUntil,
  });

  /// Creates a Attendance from Json map
  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        displayName: json['displayName'] as String,
        notAvailableUntil: (json['notAvailableUntil'] as int?) == null
            ? null
            : Timestamp.fromMillisecondsSinceEpoch(json['notAvailableUntil'] as int),
      );

  final String displayName;

  final Timestamp? notAvailableUntil;

  @override
  List<Object?> get props => [displayName, notAvailableUntil];

  /// Creates a Json map from a Attendance
  Map<String, dynamic> toJson() => <String, dynamic>{
        'displayName': displayName,
        'notAvailableUntil': notAvailableUntil?.millisecondsSinceEpoch,
      };
}
