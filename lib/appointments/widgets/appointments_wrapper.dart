import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhst/appointments/bloc/appointments_bloc.dart';
import 'package:rhst/appointments/repositories/appointments_repository.dart';

class AppointmentsWrapper extends StatelessWidget {
  final Widget child;
  const AppointmentsWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AppointmentsRepository(),
      child: BlocProvider(
        create: (context) =>
            AppointmentsBloc(RepositoryProvider.of<AppointmentsRepository>(context))
              ..add(const LoadAppointmentsEvent()),
        child: child,
      ),
    );
  }
}
