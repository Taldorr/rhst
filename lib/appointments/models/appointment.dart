import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:rhst/appointments/models/carpool.dart';

class Appointment extends Equatable {
  const Appointment({
    this.id,
    required this.title,
    required this.description,
    required this.timeFrom,
    required this.timeUntil,
    required this.location,
    required this.authorId,
    this.carpools = const [],
    this.participatingDogs = const [],
    this.participatingHuman = const [],
  });

  factory Appointment.fromJson(Map<String, dynamic> json, {String? id}) => Appointment(
        id: id,
        title: json['title'] as String,
        description: json['description'] as String,
        timeFrom: json['timeFrom'] as Timestamp,
        timeUntil: json['timeUntil'] as Timestamp,
        location: json['location'] as String,
        authorId: json['authorId'] as String,
      );

  final String? id;

  final String title;

  final String description;

  final Timestamp timeFrom;

  final Timestamp timeUntil;

  final String location;

  final String authorId;

  final List<Carpool> carpools;

  final List<String> participatingHuman;

  final List<String> participatingDogs;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        timeFrom,
        timeUntil,
        location,
        authorId,
        carpools,
      ];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'description': description,
        'timeFrom': timeFrom,
        'timeUntil': timeUntil,
        'location': location,
        'authorId': authorId,
      };
}
