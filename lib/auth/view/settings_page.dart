import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhst/auth/bloc/auth_bloc.dart';
import 'package:rhst/widgets/rhst_scrollable_page_wrapper.dart';

import '../widgets/settings_body.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const SettingsPage());
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<AuthBloc>().state.user;
    if (currentUser != null) {
      return const RHSTScrollablePageWrapper(
        showNavbar: true,
        child: SettingsBody(),
      );
    }
    return Container();
  }
}
