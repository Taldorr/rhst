import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:rhst/appointments/bloc/appointments_bloc.dart';

import 'package:rhst/appointments/models/appointment.dart';
import 'package:rhst/appointments/models/carpool.dart';
import 'package:rhst/auth/auth.dart';
import 'package:rhst/profiles/models/dog.dart';
import 'package:rhst/profiles/profiles.dart';
import 'package:rhst/util/formatter.dart';
import 'package:rhst/util/snackbar_service.dart';
import 'package:rhst/widgets/rhst_datetime_selection.dart';
import 'package:rhst/widgets/rhst_form.dart';

class JoinAppointmentPage extends StatelessWidget {
  const JoinAppointmentPage({super.key});

  List<Dog> _getAvailableDogs(BuildContext context) {
    final currUserId = context.read<AuthBloc>().state.user!.uid;
    return context.read<ProfilesBloc>().getTeamByHumanId(currUserId)?.dogs ?? [];
  }

  _onSubmit(BuildContext context, Map<String, dynamic> values, Appointment appointment) {
    final currUserId = context.read<AuthBloc>().state.user!.uid;
    final dogIds = (values["dogs"] as List<Dog>).map((d) => d.id!).toList();
    context
        .read<AppointmentsBloc>()
        .joinAppointment(appointment.id!, currUserId, dogIds, values["carpool"] as Carpool)
        .then((_) {
      Navigator.of(context).popUntil((route) => route.settings.name == "appointments");
      SnackbarService().display("Anmeldung erfolgreich");
      context.read<AppointmentsBloc>().add(const LoadAppointmentsEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    final appointment = ModalRoute.of(context)!.settings.arguments as Appointment;
    return Scaffold(
      body: SafeArea(
          child: RHSTForm(
        onSubmit: (values) => _onSubmit(context, values, appointment),
        buttonLabel: "Anmelden",
        children: [
          const Text(
            "Anmeldung",
            textAlign: TextAlign.center,
          ),
          Text(
            appointment.title,
            textAlign: TextAlign.center,
          ),
          Text("${appointment.timeFrom.toLocalString()} - ${appointment.timeUntil.toLocalString()}",
              textAlign: TextAlign.center),
          const Text("Wer kommt mit dir mit?"),
          DogSelection(availableDogs: _getAvailableDogs(context)),
          const Text("Wie kommst du hin & zurück?"),
          CarpoolSelection(appointment: appointment),
        ],
      )),
    );
  }
}

class DogSelection extends StatelessWidget {
  final List<Dog> availableDogs;

  const DogSelection({Key? key, required this.availableDogs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderFilterChip<Dog>(
        name: "dogs",
        initialValue: const [],
        options: availableDogs
            .map((dog) => FormBuilderChipOption<Dog>(
                  value: dog,
                  child: Text(dog.name),
                ))
            .toList());
  }
}

class CarpoolSelection extends StatefulWidget {
  final Appointment appointment;
  const CarpoolSelection({Key? key, required this.appointment}) : super(key: key);

  @override
  State<CarpoolSelection> createState() => _CarpoolSelectionState();
}

class _CarpoolSelectionState extends State<CarpoolSelection> {
  _showCarpoolDialog(BuildContext context, FormFieldState<Carpool> field) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Column(
          children: [
            const Text("neue Fahrgemeinschaft"),
            RHSTForm(
              onSubmit: (values) => Navigator.pop(context, values),
              buttonLabel: "Erstellen",
              children: [
                FormBuilderTextField(name: "groupName"),
                const RHSTDateTimeSelection(name: "startTime"),
                FormBuilderTextField(name: "startLocation"),
              ],
            ),
          ],
        ),
      ),
    ).then((carpoolData) async {
      if (carpoolData != null) {
        final newCarpool = Carpool(
          groupName: carpoolData["groupName"],
          startTime: Timestamp.fromDate(carpoolData["startTime"]),
          startLocation: carpoolData["startLocation"],
          seatsHuman: 100,
          seatsDogs: 100,
        );
        field.didChange(newCarpool);
      }
    });
  }

  // driving alone creates an carpool with 0 seats
  _driveAlone(FormFieldState<Carpool> field) async {
    final currentUserId = context.read<AuthBloc>().state.user?.uid;
    if (currentUserId != null) {
      final newCarpool = Carpool(
        groupName: "solo_$currentUserId",
        startTime: widget.appointment.timeFrom,
        startLocation: "",
        seatsHuman: 0,
        seatsDogs: 0,
      );
      field.didChange(newCarpool);
    }
  }

  List<Widget> _buildCarpools(List<Carpool> carpools, FormFieldState<Carpool> field) {
    return carpools
        .where((cp) => cp.seatsHuman > 0)
        .map((cp) => TextButton(
              onPressed: () => field.didChange(cp),
              child: Text(cp.groupName),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<Carpool>(
      name: "carpool",
      builder: (field) => Column(
        children: [
          Row(
            children: [
              ..._buildCarpools(widget.appointment.carpools, field),
              TextButton(
                  onPressed: () => _showCarpoolDialog(context, field), child: const Text("+")),
            ],
          ),
          TextButton(onPressed: () => _driveAlone(field), child: const Text("Ich fahre alleine"))
        ],
      ),
    );
  }
}
