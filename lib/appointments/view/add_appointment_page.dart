import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:rhst/appointments/bloc/appointments_bloc.dart';
import 'package:rhst/appointments/models/appointment.dart';
import 'package:rhst/auth/auth.dart';
import 'package:rhst/util/snackbar_service.dart';
import 'package:rhst/widgets/rhst_datetime_selection.dart';
import 'package:rhst/widgets/rhst_form.dart';

class AddAppointmentPage extends StatelessWidget {
  const AddAppointmentPage({super.key});

  _onSubmit(Map<String, dynamic> values, BuildContext context) {
    final currentUserId = context.read<AuthBloc>().state.user?.uid;
    if (currentUserId != null) {
      context
          .read<AppointmentsBloc>()
          .upsertAppointment(
            currentUserId,
            Appointment(
              authorId: currentUserId,
              title: values["title"],
              description: values["description"],
              timeFrom: Timestamp.fromDate(values["timeFrom"]),
              timeUntil: Timestamp.fromDate(values["timeUntil"]),
              location: values["location"],
            ),
          )
          .then((_) {
        SnackbarService().display("Termin angelegt");
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: RHSTForm(
            onSubmit: (values) => _onSubmit(values, context),
            buttonLabel: "Termin erstellen",
            children: [
              Text("neuer Termin"),
              FormBuilderTextField(
                name: "title",
                decoration: InputDecoration(hintText: "Titel"),
                validator: FormBuilderValidators.required(),
              ),
              RHSTDateTimeSelection(
                name: "timeFrom",
                initialValue: DateTime.now(),
              ),
              RHSTDateTimeSelection(
                name: "timeUntil",
                initialValue: DateTime.now().add(Duration(hours: 3)),
              ),
              FormBuilderTextField(
                name: "description",
                minLines: 3,
                maxLines: 5,
                decoration: InputDecoration(hintText: "Beschreibung"),
                validator: FormBuilderValidators.required(),
              ),
              FormBuilderTextField(
                name: "location",
                decoration: InputDecoration(hintText: "Ort"),
                validator: FormBuilderValidators.required(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
