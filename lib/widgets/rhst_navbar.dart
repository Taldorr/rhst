import 'package:flutter/material.dart';
import 'package:rhst/constants.dart';
import 'package:rhst/widgets/rhst_card.dart';

class RHSTNavbar extends StatelessWidget {
  static const height = 100.0;
  const RHSTNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Constants.defaultSpace * 1.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          RHSTNavbarButton(
            route: "appointments",
            icon: "assets/icons/calendar.png",
            size: height,
          ),
          RHSTNavbarButton(
            route: "chat",
            icon: "assets/icons/pencil.png",
            size: height,
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
  const RHSTNavbarButton({
    Key? key,
    required this.size,
    required this.icon,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isCurrent = ModalRoute.of(context)!.settings.name == route;
    return GestureDetector(
      onTap: isCurrent
          ? null
          : () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context).pushNamed(route);
            },
      child: RHSTCard(
        inverse: isCurrent,
        child: SizedBox(
          height: size - (Constants.defaultSpace * 3),
          width: size - (Constants.defaultSpace * 3),
          child: ImageIcon(
            AssetImage(icon),
            size: 30,
          ),
        ),
      ),
    );
  }
}
