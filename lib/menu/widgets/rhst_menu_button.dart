import 'package:flutter/material.dart';
import 'package:rhst/constants.dart';
import 'package:rhst/widgets/rhst_card.dart';
import 'package:rhst/widgets/rhst_spacer.dart';

class RHSTMenuButton extends StatelessWidget {
  final String label;
  final String route;
  final String iconPath;
  const RHSTMenuButton({
    Key? key,
    required this.label,
    required this.route,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(route),
        child: Padding(
          padding: const EdgeInsets.all(Constants.defaultSpace),
          child: RHSTCard(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const RHSTSpacer(0),
                ImageIcon(
                  AssetImage(iconPath),
                  size: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
