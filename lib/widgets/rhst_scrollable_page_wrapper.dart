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
    final navBarHeight = showNavbar ? 90 : 0;
    final systemOverlayHeight = MediaQuery.of(context).viewPadding.top;
    final contentHeight = MediaQuery.of(context).size.height - navBarHeight - systemOverlayHeight;
    return SafeArea(
      child: Scaffold(
        backgroundColor: RHSTColors.neutral[100],
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            physics: const PageScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: contentHeight,
                  child: Padding(
                    padding: const EdgeInsets.all(padding),
                    child: child,
                  ),
                ),
                if (showNavbar) const RHSTNavbar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
