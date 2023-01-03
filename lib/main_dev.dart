import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rhst/firebase_options.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage =
      await HydratedStorage.build(storageDirectory: await getTemporaryDirectory());
  FlavorConfig(
    name: "DEVELOP",
    color: Colors.red,
    location: BannerLocation.bottomStart,
    variables: {
      "loginValues": {
        "email": "c.kuhnert@drk-hh-altona-mitte.de",
        "password": "password",
      },
    },
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  try {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
  } catch (e) {
    // ignore: avoid_print
    print(e);
  }
  runApp(const RHSTApp());
}
