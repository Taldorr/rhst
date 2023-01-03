import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:rhst/constants.dart';
import 'package:rhst/styles.dart';
import 'package:rhst/widgets/rhst_spacer.dart';

class RHSTSwitch extends StatelessWidget {
  final bool isActive;
  final String label;
  final double height;
  final void Function() onChange;
  const RHSTSwitch({
    Key? key,
    required this.label,
    required this.onChange,
    this.height = 24,
    this.isActive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final depth = NeumorphicTheme.of(context)!.value.theme.depth / 4;
    return GestureDetector(
      onTap: onChange,
      child: Row(
        children: [
          Text(label, style: Styles.paragraph),
          const RHSTSpacer(0.75),
          SizedBox(
            height: height,
            child: AspectRatio(
              aspectRatio: 2 / 1,
              child: Neumorphic(
                padding: const EdgeInsets.all(1),
                drawSurfaceAboveChild: false,
                style: NeumorphicStyle(
                  depth: depth,
                  boxShape: const NeumorphicBoxShape.stadium(),
                  color: const Color(0xFFF0F0F3),
                ),
                child: Neumorphic(
                  padding: const EdgeInsets.all(2),
                  drawSurfaceAboveChild: false,
                  style: NeumorphicStyle(
                    boxShape: const NeumorphicBoxShape.stadium(),
                    depth: -depth,
                    color: RHSTColors.neutral[100],
                  ),
                  child: AnimatedScale(
                    duration: Constants.defaultSwitchAnimationDuration,
                    alignment: isActive ? const Alignment(0.5, 0) : const Alignment(-0.5, 0),
                    scale: isActive ? 1 : 0.66,
                    child: RHSTAnimatedThumb(
                      depth: depth,
                      isActive: isActive,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RHSTAnimatedThumb extends StatelessWidget {
  final bool isActive;
  final double? depth;

  static const double activeDotSizeFactor = 0.3;

  const RHSTAnimatedThumb({
    Key? key,
    required this.isActive,
    this.depth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This Container is actually the inner track containing the thumb
    return AnimatedAlign(
      alignment: isActive ? Alignment.centerRight : Alignment.centerLeft,
      duration: Constants.defaultSwitchAnimationDuration,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Neumorphic(
          style: NeumorphicStyle(
            boxShape: const NeumorphicBoxShape.circle(),
            color: const Color(0xFFF0F0F3),
            depth: depth,
          ),
          child: AspectRatio(
            aspectRatio: 1,
            child: FractionallySizedBox(
              heightFactor: activeDotSizeFactor,
              widthFactor: activeDotSizeFactor,
              child: Container(
                decoration: isActive
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: RHSTColors.primary[700],
                      )
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
