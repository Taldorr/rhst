import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:rhst/styles.dart';

class RHSTInverseCard extends StatelessWidget {
  final Widget? child;
  final double? padding;
  final bool inverse;
  const RHSTInverseCard({Key? key, this.child, this.padding, this.inverse = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding ?? 0),
      decoration: BoxDecoration(
          borderRadius: Styles.borderRadiusCard,
          color: RHSTColors.neutral[100],
          boxShadow: [
            BoxShadow(
              offset: const Offset(6, 6),
              blurRadius: 8,
              color: Colors.black.withOpacity(0.3),
              inset: true,
            ),
            BoxShadow(
              offset: const Offset(3, 3),
              blurRadius: 5,
              color: Colors.black.withOpacity(0.3),
              inset: true,
            ),
            BoxShadow(
              offset: const Offset(-3, -3),
              blurRadius: 8,
              color: Colors.white.withOpacity(0.8),
              inset: true,
            ),
            BoxShadow(
              offset: const Offset(-6, -6),
              blurRadius: 10,
              color: Colors.white.withOpacity(0.8),
              inset: true,
            ),
          ]),
      child: child,
    );
  }
}
