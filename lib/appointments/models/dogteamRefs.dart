import 'package:cloud_firestore/cloud_firestore.dart';

class DogteamRefs {
  const DogteamRefs({
    required this.humanRef,
    required this.dogRefs,
    required this.id,
  });

  final DocumentReference humanRef;

  final List<DocumentReference> dogRefs;

  final String id;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'humanRef': humanRef,
        'dogRefs': dogRefs,
        'id': id,
      };
}
