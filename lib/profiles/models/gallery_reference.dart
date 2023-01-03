import 'package:equatable/equatable.dart';

class GalleryReference extends Equatable {
  const GalleryReference({required this.path, required this.position, this.id});

  final String path;

  final int position;

  final String? id;

  factory GalleryReference.fromJson(Map<String, dynamic> json, {String? id}) => GalleryReference(
        id: id,
        position: json['position'] as int,
        path: json['path'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'path': path,
        'position': position,
      };

  GalleryReference copyWith({String? id, String? path, int? position}) => GalleryReference(
        id: id ?? this.id,
        position: position ?? this.position,
        path: path ?? this.path,
      );

  @override
  List<Object?> get props => [path, id, position];
}
