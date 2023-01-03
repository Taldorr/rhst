import 'package:flutter/material.dart';
import 'package:rhst/constants.dart';
import 'package:rhst/styles.dart';

class RHSTAppBar extends StatelessWidget {
  final void Function()? onBack;
  const RHSTAppBar({Key? key, this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onBack ?? () => Navigator.of(context).pop(),
          child: const ImageIcon(
            AssetImage("assets/icons/arrow_left.png"),
            size: 56,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: Constants.defaultSpace),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: Styles.rhstLogoShadows,
            ),
            child: Image.asset(
              "assets/rhst_logo_transparent.png",
              height: 88,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).pushNamed("settings"),
          child: const ImageIcon(
            AssetImage("assets/icons/profile.png"),
            size: 56,
          ),
        ),
      ],
    );
  }
}
