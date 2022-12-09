import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:rhst/util/snackbar_service.dart';

class StorageService {
  static Future<FirebaseFile> resolveFile(String path) async {
    final ref = FirebaseStorage.instance.ref(path);
    return FirebaseFile(name: ref.name, ref: ref, url: await ref.getDownloadURL());
  }

  static UploadTask? uploadProfilePicture(String userId, File file) {
    try {
      final ref = FirebaseStorage.instance.ref("avatars/$userId");
      return ref.putFile(file, SettableMetadata());
    } on FirebaseException catch (e) {
      print(e);
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
