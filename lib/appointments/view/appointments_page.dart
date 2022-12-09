import 'package:flutter/material.dart';
import 'package:rhst/appointments/widgets/appointments_body.dart';

class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => Navigator.of(context).pushNamed("appointments/new")),
      body: const SafeArea(child: AppointmentsBody()),
    );
  }
}
