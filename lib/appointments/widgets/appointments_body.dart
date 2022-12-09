import 'package:flutter/material.dart';
import 'package:rhst/appointments/bloc/bloc.dart';

class AppointmentsBody extends StatelessWidget {
  const AppointmentsBody({super.key});

  Future<void> _onRefresh(BuildContext context) {
    context.read<AppointmentsBloc>().add(const LoadAppointmentsEvent());
    return Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentsBloc, AppointmentsState>(
      builder: (context, state) {
        final appointments = state.appointments;
        return Expanded(
          child: RefreshIndicator(
            onRefresh: () => _onRefresh(context),
            child: ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () => Navigator.of(context).pushNamed(
                  "appointments/details",
                  arguments: appointments[index],
                ),
                title: Text(appointments[index].title),
              ),
            ),
          ),
        );
      },
    );
  }
}
