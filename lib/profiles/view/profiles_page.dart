import 'package:flutter/material.dart';
import 'package:rhst/profiles/widgets/profiles_body.dart';
import 'package:rhst/widgets/rhst_scrollable_page_wrapper.dart';

class ProfilesPage extends StatelessWidget {
  const ProfilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RHSTScrollablePageWrapper(
      showNavbar: true,
      child: ProfilesBody(),
    );
  }
}
