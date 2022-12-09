import 'package:flutter/material.dart';
import 'package:rhst/constants.dart';
import 'package:rhst/styles.dart';
import 'package:rhst/widgets/rhst_navbar.dart';

class RHSTScrollablePageWrapper extends StatelessWidget {
  final Widget child;
  final bool showNavbar;
  const RHSTScrollablePageWrapper({
    Key? key,
    required this.child,
    this.showNavbar = false,
  }) : super(key: key);

  static const padding = Constants.defaultSpace;

  @override
  Widget build(BuildContext context) {
    final navBarHeight = showNavbar ? 100 : 0;
    final contentHeight = MediaQuery.of(context).size.height - (3 * padding) - navBarHeight;
    return Scaffold(
      backgroundColor: RHSTColors.neutral[100],
      body: SafeArea(
        child: Column(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: contentHeight,
                child: Padding(
                  padding: const EdgeInsets.all(padding),
                  child: child,
                ),
              ),
            ),
            if (showNavbar) const RHSTNavbar(),
          ],
        ),
      ),
    );
  }
}
