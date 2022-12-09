import 'package:flutter/material.dart';
import 'package:rhst/menu/widgets/menu_body.dart';
import 'package:rhst/widgets/rhst_scrollable_page_wrapper.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const MenuPage());
  }

  @override
  Widget build(BuildContext context) {
    return const RHSTScrollablePageWrapper(child: MenuBody());
  }
}
