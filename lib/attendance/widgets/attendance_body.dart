import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:rhst/attendance/bloc/bloc.dart';
import 'package:rhst/attendance/models/attendance.dart';
import 'package:rhst/auth/auth.dart';
import 'package:rhst/constants.dart';
import 'package:rhst/util/formatter.dart';
import 'package:rhst/widgets/rhst_form.dart';
import 'package:rhst/widgets/rhst_spacer.dart';

class AttendanceBody extends StatelessWidget {
  const AttendanceBody({super.key});

  Future<void> _onRefresh(BuildContext context) {
    context.read<AttendanceBloc>().add(const LoadAttendanceEvent());
    return Future.delayed(const Duration(seconds: 1));
  }

  _cancelAttendance(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          color: Colors.white,
          child: RHSTForm(
            buttonLabel: "Bestätigen",
            onSubmit: (values) => Navigator.of(context, rootNavigator: true).pop(values),
            children: const [
              Text("von der Bereitschaft abmelden"),
              RHSTSpacer(3),
              Text("bis:"),
              DateTimeSelection(),
            ],
          ),
        ),
      ),
    ).then((values) {
      final currentUserId = context.read<AuthBloc>().state.user?.uid;
      if (currentUserId != null) {
        context.read<AttendanceBloc>().cancelAttendance(currentUserId, values["dateTime"]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        final attendances = state.attendances;
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(Constants.defaultSpace * 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Bereitschaft",
                  textAlign: TextAlign.center,
                ),
                const RHSTSpacer(3),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => _onRefresh(context),
                    child: ListView.builder(
                      itemCount: attendances.length,
                      itemBuilder: (context, index) =>
                          AttendanceListElement(attendance: attendances[index]),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _cancelAttendance(context),
                  child: const Text("Ich kann nicht!"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AttendanceListElement extends StatelessWidget {
  const AttendanceListElement({
    Key? key,
    required this.attendance,
  }) : super(key: key);

  final Attendance attendance;

  @override
  Widget build(BuildContext context) {
    bool isAvailable = attendance.notAvailableUntil?.toDate().isBefore(DateTime.now()) ?? true;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.defaultSpace),
      child: Row(
        children: [
          _displayAvailability(isAvailable),
          const RHSTSpacer(2),
          Text(attendance.displayName),
          const Spacer(),
          Text(isAvailable ? "" : attendance.notAvailableUntil!.toLocalString())
        ],
      ),
    );
  }

  Widget _displayAvailability(bool isAvailable) {
    Color color = isAvailable ? Colors.green : Colors.red;

    return Container(
      height: 15,
      width: 15,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}

class DateTimeSelection extends StatelessWidget {
  const DateTimeSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<DateTime>(
      name: "dateTime",
      initialValue: DateTime.now(),
      builder: (field) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              IconButton(
                onPressed: () => field.didChange(field.value!.add(const Duration(days: 1))),
                icon: const Icon(Icons.arrow_drop_up_rounded),
              ),
              Text(DateFormat("dd.MM.yyyy").format(field.value ?? DateTime.now())),
              IconButton(
                onPressed: () => field.didChange(field.value!.subtract(const Duration(days: 1))),
                icon: const Icon(Icons.arrow_drop_down_rounded),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: () => field.didChange(field.value!.add(const Duration(hours: 1))),
                icon: const Icon(Icons.arrow_drop_up_rounded),
              ),
              Text("${DateFormat("HH:00").format(field.value ?? DateTime.now())} Uhr"),
              IconButton(
                onPressed: () => field.didChange(field.value!.subtract(const Duration(hours: 1))),
                icon: const Icon(Icons.arrow_drop_down_rounded),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
