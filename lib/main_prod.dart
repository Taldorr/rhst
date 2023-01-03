import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rhst/app.dart';
import 'package:rhst/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage =
      await HydratedStorage.build(storageDirectory: await getTemporaryDirectory());
  FlavorConfig(
    name: "PROD",
    color: Colors.green,
    variables: {},
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const RHSTApp());
}
