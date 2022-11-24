import 'package:flutter/material.dart';
import 'package:rhst/menu/bloc/bloc.dart';
import 'package:rhst/menu/widgets/menu_body.dart';

/// {@template menu_page}
/// A description for MenuPage
/// {@endtemplate}
class MenuPage extends StatelessWidget {
  /// {@macro menu_page}
  const MenuPage({super.key});

  /// The static route for MenuPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const MenuPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MenuBloc(),
      child: const Scaffold(
        body: MenuView(),
      ),
    );
  }    
}

/// {@template menu_view}
/// Displays the Body of MenuView
/// {@endtemplate}
class MenuView extends StatelessWidget {
  /// {@macro menu_view}
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MenuBody();
  }
}
