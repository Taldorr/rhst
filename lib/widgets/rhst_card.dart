import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:rhst/styles.dart';

class RHSTCard extends StatelessWidget {
  final Widget? child;
  final double? paddingAll;
  final EdgeInsets? padding;
  final bool inverse;
  final Color? color;
  const RHSTCard({
    Key? key,
    this.child,
    this.paddingAll,
    this.inverse = false,
    this.padding,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final depth = NeumorphicTheme.of(context)!.value.theme.depth;
    return Neumorphic(
      padding: padding ?? EdgeInsets.all(paddingAll ?? 0),
      style: NeumorphicStyle(
        color: color ?? RHSTColors.neutral[100],
        boxShape: NeumorphicBoxShape.roundRect(Styles.borderRadiusCard),
        depth: inverse ? -depth : depth,
      ),
      child: child,
    );
  }
}
