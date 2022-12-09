import 'package:flutter/material.dart';
import 'package:rhst/constants.dart';

class RHSTSpacer extends StatelessWidget {
  final double multiplier;
  const RHSTSpacer(this.multiplier, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Constants.defaultSpace * multiplier,
      width: Constants.defaultSpace * multiplier,
    );
  }
}
