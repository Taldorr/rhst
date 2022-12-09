import 'package:flutter/material.dart';
import 'package:rhst/profiles/models/human.dart';

class ProfileDetailsHumanPage extends StatelessWidget {
  const ProfileDetailsHumanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final human = ModalRoute.of(context)!.settings.arguments as Human;
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Profil",
            textAlign: TextAlign.center,
          ),
          Text(human.name),
        ],
      )),
    );
  }
}
