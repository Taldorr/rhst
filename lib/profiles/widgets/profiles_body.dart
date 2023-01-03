import 'package:flutter/material.dart';
import 'package:rhst/constants.dart';
import 'package:rhst/profiles/bloc/bloc.dart';
import 'package:rhst/profiles/widgets/rhst_members_grid.dart';
import 'package:rhst/styles.dart';
import 'package:rhst/widgets/rhst_appbar.dart';
import 'package:rhst/widgets/rhst_card.dart';

class ProfilesBody extends StatelessWidget {
  const ProfilesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilesBloc, ProfilesState>(
      builder: (context, state) {
        final profiles = state.profiles;
        return Column(
          children: [
            const RHSTAppBar(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Constants.defaultSpace * 4,
                vertical: Constants.defaultSpace * 3,
              ),
              child: RHSTCard(
                paddingAll: Constants.defaultSpace * 2,
                inverse: true,
                child: Column(
                  children: [
                    FittedBox(
                      child: Text(
                        "Hundestaffel Hamburg\nAltona-Mitte",
                        style: Styles.headline,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const FittedBox(
                      child: Text(
                        "Schön, dass es euch gibt!",
                        style: Styles.subHeadline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: RHSTMembersGrid(profiles: profiles)),
          ],
        );
      },
    );
  }
}
