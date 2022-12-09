import 'package:flutter/material.dart';
import 'package:rhst/constants.dart';

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
            size: 30,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: Constants.defaultSpace * 2.5),
          child: Image.asset("assets/icons/rhst_logo_small.png", height: 80),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).pushNamed("settings"),
          child: const ImageIcon(
            AssetImage("assets/icons/profile.png"),
            size: 30,
          ),
        ),
      ],
    );
  }
}
