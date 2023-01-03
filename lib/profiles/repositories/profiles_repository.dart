// coverage:ignore-file

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rhst/profiles/models/dog.dart';
import 'package:rhst/profiles/models/gallery_reference.dart';
import 'package:rhst/profiles/models/human.dart';

class ProfilesRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<List<Human>> getAll() async {
    List<Future<Human>> results = [];
    await _firestore
        .collection("humans")
        .get()
        .then((snap) => snap.docs.forEach((doc) => results.add(_buildProfile(doc))));
    return Future.wait(results);
  }

  Future<Human> _buildProfile(QueryDocumentSnapshot<Map<String, dynamic>> humanDoc) async {
    final human = Human.fromJson(humanDoc.data(), id: humanDoc.id);
    final List<Dog> dogs = await _buildDogs(human.id!);
    final List<GalleryReference> galleryRefs = await _buildGalleryRefs(human.id!);
    galleryRefs.sort((a, b) => a.position.compareTo(b.position));
    return human.copyWith(dogs: dogs, galleryReferences: galleryRefs);
  }

  Future<List<Dog>> _buildDogs(String humanId) =>
      _firestore.collection("humans/$humanId/dogs").get().then(
          (snap) => snap.docs.map((dogDoc) => Dog.fromJson(dogDoc.data(), id: dogDoc.id)).toList());

  Future<List<GalleryReference>> _buildGalleryRefs(String humanId) =>
      _firestore.collection("humans/$humanId/gallery").get().then((snap) => snap.docs
          .map((galleryRefDoc) =>
              GalleryReference.fromJson(galleryRefDoc.data(), id: galleryRefDoc.id))
          .toList());

  Future<void> addPictureToGallery(String humanId, GalleryReference galleryRef) async {
    final humanRef = _firestore.doc("humans/$humanId");

    if ((await humanRef.get()).exists) {
      await _firestore.collection("humans/$humanId/gallery").add(galleryRef.toJson());
      return;
    }
    throw Exception("doc-not-found");
  }

  Future<void> addHumanAvatar(String humanId, String path) async {
    final humanRef = _firestore.doc("humans/$humanId");

    if ((await humanRef.get()).exists) {
      await humanRef.update({"profile_pic_path": path});
      return;
    }
    throw Exception("doc-not-found");
  }

  Future<void> addDogAvatar(String humanId, String dogId, String path) async {
    final dogRef = _firestore.doc("humans/$humanId/dogs/$dogId");

    if ((await dogRef.get()).exists) {
      await dogRef.update({"profile_pic_path": path});
      return;
    }
    throw Exception("doc-not-found");
  }
}
