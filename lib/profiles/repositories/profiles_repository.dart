// coverage:ignore-file

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rhst/profiles/models/dog.dart';
import 'package:rhst/profiles/models/human.dart';

import '../models/dogteam.dart';

class ProfilesRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<List<Dogteam>> getAllDogteams() async {
    List<Future<Dogteam>> results = [];
    await _firestore
        .collection("dogteams")
        .get()
        .then((snap) => snap.docs.forEach((doc) => results.add(_resolveDogTeamRefs(doc))));
    return Future.wait(results);
  }

  Future<Dogteam> _resolveDogTeamRefs(QueryDocumentSnapshot<Map<String, dynamic>> doc) async {
    final data = doc.data();
    final human = await _getHumanByRef(data["humanRef"] as DocumentReference);
    List<Future<Dog>> dogsFutures = [];
    await _firestore.collection("dogteams/${doc.id}/dogRefs").get().then((snap) => snap.docs
        .forEach((dogRefDoc) =>
            dogsFutures.add(_getDogByRef(dogRefDoc.data()["dogRef"] as DocumentReference))));

    return Dogteam(human: human, dogs: await Future.wait(dogsFutures), id: doc.id);
  }

  Future<Human> _getHumanByRef(DocumentReference ref) {
    return ref.get().then(
          (humanData) => Human.fromJson(
            humanData.data() as Map<String, dynamic>,
            id: humanData.id,
          ),
        );
  }

  Future<Dog> _getDogByRef(DocumentReference ref) {
    return ref.get().then(
          (dogData) => Dog.fromJson(
            dogData.data() as Map<String, dynamic>,
            id: dogData.id,
          ),
        );
  }
}
