import 'package:flutter/material.dart';
import 'package:rhst/styles.dart';
import 'package:rhst/widgets/rhst_spacer.dart';

class RHSTPrimaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  final IconData? icon;
  const RHSTPrimaryButton({
    Key? key,
    this.onPressed,
    required this.label,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: Styles.borderRadiusInput,
          boxShadow: Styles.rhstButtonShadows,
          color: RHSTColors.primary[700],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              if (icon != null) Icon(icon!, color: Colors.white, size: 16),
              if (icon != null) const RHSTSpacer(0.5),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
