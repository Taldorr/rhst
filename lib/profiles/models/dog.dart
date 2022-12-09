import 'package:cloud_firestore/cloud_firestore.dart';

class Dog {
  Dog({this.name = "", this.birthday, this.id});

  final String name;

  final Timestamp? birthday;

  final String? id;

  factory Dog.fromJson(Map<String, dynamic> json, {String? id}) => Dog(
        id: id,
        name: json['name'] as String,
        birthday: json['birthday'] as Timestamp?,
      );
}
