import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Dog extends Equatable {
  const Dog({this.name = "", this.birthday, this.id, this.profilePicPath});

  final String name;

  final Timestamp? birthday;

  final String? id;

  final String? profilePicPath;

  factory Dog.fromJson(Map<String, dynamic> json, {String? id}) => Dog(
        id: id,
        name: json['name'] as String,
        birthday: json['birthday'] as Timestamp?,
        profilePicPath: json['profile_pic_path'] as String?,
      );

  Dog copyWith({String? id, String? name, Timestamp? birthday, String? profilePicPath}) => Dog(
        id: id ?? this.id,
        name: name ?? this.name,
        birthday: birthday ?? this.birthday,
        profilePicPath: profilePicPath ?? this.profilePicPath,
      );

  @override
  List<Object?> get props => [name, birthday, id, profilePicPath];
}
