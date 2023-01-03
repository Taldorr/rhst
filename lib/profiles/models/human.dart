import 'package:equatable/equatable.dart';
import 'package:rhst/profiles/models/gallery_reference.dart';

import 'dog.dart';

class Human extends Equatable {
  const Human({
    required this.firstName,
    required this.lastName,
    this.id,
    this.profilePicPath,
    this.dogs = const [],
    this.galleryReferences = const [],
  });

  final String firstName;
  final String lastName;
  final String? id;
  final String? profilePicPath;
  final List<Dog> dogs;
  final List<GalleryReference> galleryReferences;

  factory Human.fromJson(
    Map<String, dynamic> json, {
    String? id,
    List<Dog> dogs = const [],
    List<GalleryReference> galleryReferences = const [],
  }) =>
      Human(
        id: id,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        profilePicPath: json['profile_pic_path'] as String?,
        dogs: dogs,
        galleryReferences: galleryReferences,
      );
  Human copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? profilePicPath,
    List<Dog>? dogs,
    List<GalleryReference>? galleryReferences,
  }) =>
      Human(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        profilePicPath: profilePicPath ?? this.profilePicPath,
        dogs: dogs ?? this.dogs,
        galleryReferences: galleryReferences ?? this.galleryReferences,
      );

  @override
  List<Object?> get props => [id, firstName, lastName, profilePicPath, dogs, galleryReferences];
}
