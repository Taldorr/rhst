import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:rhst/constants.dart';
import 'package:rhst/styles.dart';
import 'package:rhst/widgets/rhst_card.dart';

class RHSTNavbar extends StatelessWidget {
  static const height = 90.0;
  const RHSTNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          RHSTNavbarButton(
            route: "appointments",
            icon: "assets/icons/calendar.png",
            size: height,
            isDisabled: true,
          ),
          RHSTNavbarButton(
            route: "chat",
            icon: "assets/icons/pencil.png",
            size: height,
            isDisabled: true,
          ),
          RHSTNavbarButton(
            route: "attendance",
            icon: "assets/icons/alarm_bell.png",
            size: height,
          ),
          RHSTNavbarButton(
            route: "profiles",
            icon: "assets/icons/users.png",
            size: height,
          ),
        ],
      ),
    );
  }
}

class RHSTNavbarButton extends StatelessWidget {
  final double size;
  final String icon;
  final String route;
  final bool isDisabled;
  const RHSTNavbarButton({
    Key? key,
    required this.size,
    required this.icon,
    required this.route,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isCurrent = ModalRoute.of(context)!.settings.name == route;
    return SizedBox(
      height: size - (Constants.defaultSpace * 3),
      width: size - (Constants.defaultSpace * 3),
      child: Stack(
        children: [
          GestureDetector(
            onTap: isCurrent || isDisabled
                ? null
                : () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.of(context).pushNamed(route);
                  },
            child: RHSTCard(
              inverse: isCurrent || isDisabled,
              child: SizedBox(
                height: size - (Constants.defaultSpace * 3),
                width: size - (Constants.defaultSpace * 3),
                child: ImageIcon(
                  AssetImage(icon),
                  size: 30,
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
                    style: Styles.comingSoon.copyWith(fontSize: 12),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
