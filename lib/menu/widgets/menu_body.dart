import 'package:flutter/material.dart';
import 'package:rhst/auth/auth.dart';
import 'package:rhst/menu/bloc/bloc.dart';

class MenuBody extends StatelessWidget {
  const MenuBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => context.read<AuthBloc>().add(const LogoutAuthEvent()),
              child: const Text("Logout"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed("attendance"),
              child: const Text("Bereitschaft"),
            ),
          ],
        );
      },
    );
  }
}
