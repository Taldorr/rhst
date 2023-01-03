import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:rhst/styles.dart';
import 'package:rhst/widgets/rhst_card.dart';
import 'package:rhst/widgets/rhst_spacer.dart';

class RHSTMenuButton extends StatelessWidget {
  final String label;
  final String route;
  final String iconPath;
  final bool isDisabled;
  const RHSTMenuButton({
    Key? key,
    required this.label,
    required this.route,
    required this.iconPath,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: GestureDetector(
              onTap: isDisabled ? null : () => Navigator.of(context).pushNamed(route),
              child: RHSTCard(
                inverse: isDisabled,
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
          //TODO this can be removed once all functions are implemented
          if (isDisabled)
            Align(
              alignment: Alignment.center,
              child: Transform.rotate(
                angle: -math.pi / 4,
                child: FittedBox(
                  child: Text(
                    "Demnächst",
                    style: Styles.comingSoon,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
