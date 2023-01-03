import 'package:flutter/material.dart';
import 'package:rhst/auth/auth.dart';
import 'package:rhst/constants.dart';
import 'package:rhst/styles.dart';
import 'package:rhst/widgets/rhst_appbar.dart';
import 'package:rhst/widgets/rhst_card.dart';
import 'package:rhst/widgets/rhst_spacer.dart';

import 'rhst_menu_button.dart';

class MenuBody extends StatelessWidget {
  const MenuBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final firstName = state.settings?.firstName ?? "";
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RHSTAppBar(
              onBack: () => context.read<AuthBloc>().add(const LogoutAuthEvent()),
            ),
            Padding(
              padding: const EdgeInsets.all(Constants.defaultSpace * 2),
              child: RHSTCard(
                inverse: true,
                child: SizedBox(
                  height: 150,
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
              child: Padding(
                padding: const EdgeInsets.only(
                  left: Constants.defaultSpace * 2,
                  right: Constants.defaultSpace * 2,
                  bottom: Constants.defaultSpace * 2,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          RHSTMenuButton(
                            label: "Staffelkalender",
                            route: "appointments",
                            iconPath: "assets/icons/calendar.png",
                            isDisabled: true,
                          ),
                          RHSTSpacer(2),
                          RHSTMenuButton(
                            label: "Gruppenchat",
                            route: "chat",
                            iconPath: "assets/icons/pencil.png",
                            isDisabled: true,
                          ),
                        ],
                      ),
                    ),
                    const RHSTSpacer(2),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          RHSTMenuButton(
                            label: "Bereitschaft",
                            route: "attendance",
                            iconPath: "assets/icons/alarm_bell.png",
                          ),
                          RHSTSpacer(2),
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
            ),
          ],
        );
      },
    );
  }
}
