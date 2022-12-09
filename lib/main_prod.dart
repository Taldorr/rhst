import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rhst/attendance/attendance.dart';
import 'package:rhst/firebase_options.dart';
import 'package:rhst/menu/menu.dart';
import 'package:rhst/profiles/widgets/profiles_wrapper.dart';
import 'package:rhst/styles.dart';

import 'appointments/appointments.dart';
import 'auth/auth.dart';
import 'profiles/profiles.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage =
      await HydratedStorage.build(storageDirectory: await getTemporaryDirectory());
  FlavorConfig(
    name: "PROD",
    color: Colors.green,
    variables: {
      "loginValues": {},
    },
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  initializeDateFormatting("de_DE");
  runApp(const RHSTApp());
}

final snackbarKey = GlobalKey<ScaffoldMessengerState>();

class RHSTApp extends StatelessWidget {
  const RHSTApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthWrapper(
      child: AppointmentsWrapper(
        child: ProfilesWrapper(
          child: MaterialApp(
            title: 'Flutter Demo',
            scaffoldMessengerKey: snackbarKey,
            theme: ThemeData(
              colorSchemeSeed: RHSTColors.primary,
            ),
            //initialRoute: "menu",
            routes: {
              'splash': (context) => const SplashPage(),
              'menu': (context) => const MenuPage(),
              'login': (context) => const LoginPage(),
              'forgot-password': (context) => const ForgotPasswordPage(),
              'attendance': (context) => const AttendancePage(),
              'appointments': (context) => const AppointmentsPage(),
              'appointments/new': (context) => const AddAppointmentPage(),
              'appointments/details': (context) => const AppointmentDetailsPage(),
              'appointments/join': (context) => const JoinAppointmentPage(),
              'profiles': (context) => const ProfilesPage(),
              'profiles/details': (context) => const ProfileDetailsPage(),
              'profiles/details/human': (context) => const ProfileDetailsHumanPage(),
              'profiles/details/dog': (context) => const ProfileDetailsDogPage(),
              'settings': (context) => const SettingsPage(),
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
        ),
      ),
    );
  }
}
