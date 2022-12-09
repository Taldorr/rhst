import 'package:flutter/material.dart';
import 'package:rhst/auth/auth.dart';
import 'package:rhst/constants.dart';
import 'package:rhst/styles.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const LoginPage(),
      settings: const RouteSettings(name: "splash"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Constants.defaultSpace * 6),
          child: Column(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: Styles.rhstLogoShadows,
                  ),
                  child: Image.asset("assets/rhst_logo_transparent.png"),
                ),
              ),
              const Spacer(),
              Image.asset("assets/async_logo.png"),
              const Text("by Async Software"),
            ],
          ),
        ),
      ),
    );
  }
}
