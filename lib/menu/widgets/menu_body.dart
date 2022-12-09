import 'package:flutter/material.dart';
import 'package:rhst/auth/auth.dart';
import 'package:rhst/constants.dart';
import 'package:rhst/styles.dart';
import 'package:rhst/widgets/rhst_appbar.dart';
import 'package:rhst/widgets/rhst_card.dart';

import 'rhst_menu_button.dart';

class MenuBody extends StatelessWidget {
  const MenuBody({super.key});

  @override
  Widget build(BuildContext context) {
    final firstName = context.read<AuthBloc>().state.settings?.firstName ?? "";
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RHSTAppBar(
          onBack: () => context.read<AuthBloc>().add(const LogoutAuthEvent()),
        ),
        Padding(
          padding: const EdgeInsets.all(Constants.defaultSpace * 4),
          child: RHSTCard(
            inverse: true,
            child: SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(Constants.defaultSpace * 2.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Hey $firstName!", style: Styles.headline),
                    Text(
                      "Was steht als nächstes an?",
                      style: Styles.paragraph,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: const [
                    RHSTMenuButton(
                      label: "Staffelkalender",
                      route: "appointments",
                      iconPath: "assets/icons/calendar.png",
                    ),
                    RHSTMenuButton(
                      label: "Gruppenchat",
                      route: "chat",
                      iconPath: "assets/icons/pencil.png",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: const [
                    RHSTMenuButton(
                      label: "Bereitschaft",
                      route: "attendance",
                      iconPath: "assets/icons/alarm_bell.png",
                    ),
                    RHSTMenuButton(
                      label: "Mitglieder",
                      route: "profiles",
                      iconPath: "assets/icons/users.png",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
