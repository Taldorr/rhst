import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Carpool extends Equatable {
  const Carpool({
    required this.groupName,
    required this.startTime,
    required this.startLocation,
    required this.seatsHuman,
    required this.seatsDogs,
    this.id,
    this.participatingDogs = const [],
    this.participatingHuman = const [],
  });

  factory Carpool.fromJson(Map<String, dynamic> json, {String? id}) => Carpool(
        id: id,
        groupName: json['groupName'] as String,
        startTime: json['startTime'] as Timestamp,
        startLocation: json['startLocation'] as String,
        seatsHuman: json['seatsHuman'] as int,
        seatsDogs: json['seatsDogs'] as int,
      );

  final String groupName;

  final Timestamp startTime;

  final String startLocation;

  final int seatsHuman;

  final List<String> participatingHuman;

  final int seatsDogs;

  final List<String> participatingDogs;

  final String? id;

  @override
  List<Object?> get props => [
        groupName,
        startTime,
        startLocation,
        seatsHuman,
        seatsDogs,
        participatingDogs,
        participatingHuman
      ];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'groupName': groupName,
        'startTime': startTime,
        'startLocation': startLocation,
        'seatsHuman': seatsHuman,
        'seatsDogs': seatsDogs,
      };
}
