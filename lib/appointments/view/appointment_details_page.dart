import 'package:flutter/material.dart';
import 'package:rhst/util/formatter.dart';
import 'package:rhst/appointments/models/appointment.dart';

class AppointmentDetailsPage extends StatelessWidget {
  const AppointmentDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appointment = ModalRoute.of(context)!.settings.arguments as Appointment;
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            appointment.title,
            textAlign: TextAlign.center,
          ),
          Text("${appointment.timeFrom.toLocalString()} - ${appointment.timeUntil.toLocalString()}",
              textAlign: TextAlign.center),
          Text(
            appointment.description,
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed(
              "appointments/join",
              arguments: appointment,
            ),
            child: const Text("Anmelden"),
          ),
        ],
      )),
    );
  }
}
