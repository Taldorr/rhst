import 'package:flutter/material.dart';
import 'package:rhst/constants.dart';
import 'package:rhst/profiles/models/dogteam.dart';

import 'rhst_profile_avatar.dart';

class RHSTMembersGrid extends StatelessWidget {
  final List<Dogteam> profiles;
  const RHSTMembersGrid({Key? key, required this.profiles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 5,
      mainAxisSpacing: Constants.defaultSpace,
      children: profiles
          .map((p) => GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(
                  "profiles/details",
                  arguments: p,
                ),
                child: ProfileAvatar(
                  name: p.human.name,
                  imagePath: p.human.profilePicPath,
                ),
              ))
          .toList(),
    );
  }
}
