import 'package:flutter/material.dart';

import '../models/dog.dart';
import '../models/dogteam.dart';

class ProfileDetailsPage extends StatelessWidget {
  const ProfileDetailsPage({super.key});

  _buildDogButtons(BuildContext context, List<Dog> dogs) => dogs.map(
        (dog) => ElevatedButton(
          onPressed: () => Navigator.of(context).pushNamed("profiles/details/dog", arguments: dog),
          child: Text(dog.name),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final profile = ModalRoute.of(context)!.settings.arguments as Dogteam;
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Profil",
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: () =>
                Navigator.of(context).pushNamed("profiles/details/human", arguments: profile.human),
            child: Text(profile.human.name),
          ),
          ..._buildDogButtons(context, profile.dogs),
        ],
      )),
    );
  }
}
