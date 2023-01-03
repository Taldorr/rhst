import 'package:flutter/material.dart';
import 'package:rhst/constants.dart';
import 'package:rhst/profiles/models/human.dart';

import 'rhst_profile_avatar_small.dart';

class RHSTMembersGrid extends StatelessWidget {
  final List<Human> profiles;
  const RHSTMembersGrid({Key? key, required this.profiles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 5,
      mainAxisSpacing: Constants.defaultSpace,
      crossAxisSpacing: Constants.defaultSpace,
      children: profiles
          .map(
            (human) => GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                "profiles/details",
                arguments: human.id,
              ),
              child: RHSTProfileAvatarSmall(
                name: "${human.firstName} ${human.lastName[0]}.",
                imagePath: human.profilePicPath,
              ),
            ),
          )
          .toList(),
    );
  }
}
