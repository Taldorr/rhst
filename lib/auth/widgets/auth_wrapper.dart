import 'package:flutter/material.dart';
import 'package:rhst/auth/auth.dart';
import 'package:rhst/auth/repositories/auth_repository.dart';

class AuthWrapper extends StatelessWidget {
  final Widget child;
  const AuthWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) =>
            AuthBloc(RepositoryProvider.of<AuthRepository>(context))..add(const InitAuthEvent()),
        child: child,
      ),
    );
  }
}
