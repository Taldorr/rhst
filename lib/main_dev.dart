import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rhst/attendance/attendance.dart';
import 'package:rhst/auth/view/forgot_password_page.dart';
import 'package:rhst/firebase_options.dart';
import 'package:rhst/menu/menu.dart';

import 'auth/auth.dart';

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
  } catch (e) {
    // ignore: avoid_print
    print(e);
  }

  runApp(const RHSTApp());
}

final snackbarKey = GlobalKey<ScaffoldMessengerState>();

class RHSTApp extends StatelessWidget {
  const RHSTApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthWrapper(
      child: MaterialApp(
        title: 'Flutter Demo',
        scaffoldMessengerKey: snackbarKey,
        theme: ThemeData(colorSchemeSeed: Colors.red),
        routes: {
          'menu': (context) => const MenuPage(),
          'login': (context) => const LoginPage(),
          'forgot-password': (context) => const ForgotPasswordPage(),
          'attendance': (context) => const AttendancePage(),
        },
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state.user == null) {
              return const LoginPage();
            } else {
              return const MenuPage();
            }
          },
        ),
      ),
    );
  }
}
