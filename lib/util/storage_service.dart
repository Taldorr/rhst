import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:rhst/util/snackbar_service.dart';
import 'package:uuid/uuid.dart';

import 'logger.dart';

class StorageService {
  static String dogProfilePicturePath(String dogId) => "dogs/avatars/$dogId";

  static String galleryCollectionPath(String humanId, String uuid) => "gallery/$humanId/$uuid";

  static Future<FirebaseFile?> resolveFile(String path) async {
    try {
      final ref = FirebaseStorage.instance.ref(path);
      return FirebaseFile(name: ref.name, ref: ref, url: await ref.getDownloadURL());
    } catch (e) {
      Logger.log(e);
      return null;
    }
  }

  static UploadTask? uploadHumanProfilePicture(String userId, File file) =>
      _uploadPicture("avatars/$userId", file);

  static UploadTask? uploadDogProfilePicture(String dogId, File file) =>
      _uploadPicture(dogProfilePicturePath(dogId), file);

  static UploadTask? uploadGalleryPicture(String humanId, File file) =>
      _uploadPicture(galleryCollectionPath(humanId, const Uuid().v4()), file);

  static UploadTask? _uploadPicture(String path, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(path);
      return ref.putFile(file, SettableMetadata());
    } on FirebaseException catch (e) {
      Logger.log(e);
      SnackbarService().display("Upload fehlgeschlagen");
      return null;
    }
  }
}

class FirebaseFile {
  final String name;
  final String url;
  final Reference ref;

  FirebaseFile({
    required this.name,
    required this.url,
    required this.ref,
  });
}
