import 'package:flutter/material.dart';
import 'package:rhst/profiles/widgets/profiles_team_body.dart';
import 'package:rhst/widgets/rhst_scrollable_page_wrapper.dart';

class ProfileTeamPage extends StatelessWidget {
  const ProfileTeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RHSTScrollablePageWrapper(
      showNavbar: true,
      child: ProfileTeamBody(),
    );
  }
}
