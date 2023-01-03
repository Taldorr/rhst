import 'package:flutter/material.dart';
import 'package:rhst/styles.dart';
import 'package:rhst/widgets/rhst_resolved_image.dart';
import 'package:rhst/widgets/rhst_spacer.dart';

class RHSTProfileAvatarSmall extends StatelessWidget {
  final String name;
  final String? imagePath;
  const RHSTProfileAvatarSmall({Key? key, required this.name, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(child: Text(name, style: Styles.paragraph)),
        const RHSTSpacer(0.5),
        Flexible(
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Container(
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
              child: ClipOval(
                child: imagePath != null
                    ? ResolvedImage(path: imagePath!)
                    : Image.asset("assets/icons/profile.png"),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
