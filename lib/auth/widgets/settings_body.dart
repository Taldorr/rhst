import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rhst/auth/bloc/auth_bloc.dart';
import 'package:rhst/constants.dart';
import 'package:rhst/styles.dart';
import 'package:rhst/widgets/rhst_primary_button.dart';
import 'package:rhst/widgets/rhst_resolved_image.dart';
import 'package:rhst/widgets/rhst_spacer.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  _selectNewImage(BuildContext context) {
    ImagePicker().pickImage(source: ImageSource.gallery).then((result) {
      if (result == null) return;
      final path = result.path;
      context.read<AuthBloc>().updateProfilePicture(path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final settings = state.settings;
        if (settings != null) {
          return Padding(
            padding: const EdgeInsets.all(Constants.defaultSpace * 5),
            child: Column(
              children: [
                Text(
                  "Hallo ${settings.firstName},",
                  style: Styles.headline,
                  textAlign: TextAlign.center,
                ),
                const RHSTSpacer(2),
                Text(
                  "Bis jetzt kannst du hier nur dein Profilbild ändern. Wir arbeiten aber schon an neuen Funktionalitäten!",
                  style: Styles.paragraph,
                  textAlign: TextAlign.center,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: ResolvedImage(path: settings.profilePicPath),
                        ),
                      ),
                      const RHSTSpacer(5),
                      RHSTPrimaryButton(
                        label: "Bild ändern",
                        onPressed: () => _selectNewImage(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
