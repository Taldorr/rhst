import 'package:flutter/material.dart';
import 'package:rhst/profiles/models/dog.dart';
import 'package:rhst/util/formatter.dart';

class ProfileDetailsDogPage extends StatelessWidget {
  const ProfileDetailsDogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dog = ModalRoute.of(context)!.settings.arguments as Dog;
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Profil",
            textAlign: TextAlign.center,
          ),
          Text(dog.name),
          Text(dog.birthday?.toLocalString() ?? "-"),
        ],
      )),
    );
  }
}
