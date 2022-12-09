import 'package:flutter/material.dart';
import 'package:rhst/styles.dart';
import 'package:rhst/widgets/rhst_card_inverse.dart';

class RHSTCard extends StatelessWidget {
  final Widget? child;
  final double? padding;
  final bool inverse;
  const RHSTCard({Key? key, this.child, this.padding, this.inverse = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (inverse) {
      return RHSTInverseCard(padding: padding, child: child);
    }
    return Container(
      padding: EdgeInsets.all(padding ?? 0),
      decoration: BoxDecoration(
        borderRadius: Styles.borderRadiusCard,
        boxShadow: Styles.rhstOuterShadows,
        color: RHSTColors.neutral[100],
      ),
      child: child,
    );
  }
}
