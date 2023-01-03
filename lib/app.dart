import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:rhst/attendance/attendance.dart';
import 'package:rhst/generated/l10n.dart';
import 'package:rhst/menu/menu.dart';
import 'package:rhst/profiles/widgets/profiles_wrapper.dart';
import 'package:rhst/styles.dart';

import 'appointments/appointments.dart';
import 'auth/auth.dart';
import 'profiles/profiles.dart';

final snackbarKey = GlobalKey<ScaffoldMessengerState>();

class RHSTApp extends StatelessWidget {
  const RHSTApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthWrapper(
      child: AppointmentsWrapper(
        child: ProfilesWrapper(
          child: NeumorphicTheme(
            theme: const NeumorphicThemeData(
              depth: 4,
              intensity: 1,
            ),
            child: MaterialApp(
              title: 'RHST',
              scaffoldMessengerKey: snackbarKey,
              theme: ThemeData(
                colorSchemeSeed: RHSTColors.primary,
              ),
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
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
                'profiles/details': (context) => const ProfileTeamPage(),
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
      ),
    );
  }
}
