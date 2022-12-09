import 'package:flutter/material.dart';
import 'package:rhst/styles.dart';
import 'package:rhst/widgets/rhst_resolved_image.dart';

class ProfileAvatar extends StatelessWidget {
  final String name;
  final String? imagePath;
  const ProfileAvatar({Key? key, required this.name, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(name, style: Styles.paragraph),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: const Offset(3, 3),
                blurRadius: 5,
                color: Colors.black.withOpacity(0.25),
              ),
            ],
            borderRadius: BorderRadius.circular(100),
            color: Colors.white,
          ),
          child: imagePath != null
              ? SizedBox(
                  width: 60,
                  height: 60,
                  child: ClipOval(
                    child: ResolvedImage(path: imagePath!),
                  ),
                )
              : Image.asset("assets/icons/profile.png"),
        )
      ],
    );
  }
}
