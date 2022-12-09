import 'package:flutter/material.dart';
import 'package:rhst/attendance/bloc/bloc.dart';
import 'package:rhst/auth/auth.dart';
import 'package:rhst/constants.dart';
import 'package:rhst/styles.dart';
import 'package:rhst/widgets/rhst_appbar.dart';
import 'package:rhst/widgets/rhst_card.dart';
import 'package:rhst/widgets/rhst_datetime_selection.dart';
import 'package:rhst/widgets/rhst_form.dart';
import 'package:rhst/widgets/rhst_primary_button.dart';
import 'package:rhst/widgets/rhst_spacer.dart';

import 'attendance_list_element.dart';

class AttendanceBody extends StatelessWidget {
  const AttendanceBody({super.key});

  Future<void> _onRefresh(BuildContext context) {
    context.read<AttendanceBloc>().add(const LoadAttendanceEvent());
    return Future.delayed(const Duration(seconds: 1));
  }

  _cancelAttendance(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AttendanceDialog(),
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
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: Constants.defaultSpace * 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const RHSTAppBar(),
              const RHSTSpacer(3),
              RHSTCard(
                inverse: true,
                padding: Constants.defaultSpace * 3,
                child: Column(
                  children: [
                    Text("Bereitschaftsdienst", style: Styles.headline),
                    //TODO
                    const Text(
                      "nächste Bereitschaft: xxxxxxxx-xxxxxx",
                      style: Styles.subHeadline,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const RHSTSpacer(3),
              Text("aktuelle Verfügbarkeit", style: Styles.paragraph),
              const RHSTSpacer(1.5),
              Expanded(
                child: RHSTCard(
                  padding: Constants.defaultSpace * 4,
                  child: RefreshIndicator(
                    onRefresh: () => _onRefresh(context),
                    child: ListView.builder(
                      itemCount: attendances.length,
                      itemBuilder: (context, index) =>
                          AttendanceListElement(attendance: attendances[index]),
                    ),
                  ),
                ),
              ),
              const RHSTSpacer(3),
              RHSTPrimaryButton(
                icon: Icons.close,
                label: "Ich kann leider nicht!",
                onPressed: () => _cancelAttendance(context),
              ),
              const RHSTSpacer(3),
            ],
          ),
        );
      },
    );
  }
}

class AttendanceDialog extends StatelessWidget {
  const AttendanceDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: RHSTColors.neutral[100],
      shape: RoundedRectangleBorder(
        borderRadius: Styles.borderRadiusCard,
      ),
      child: Padding(
        padding: const EdgeInsets.all(Constants.defaultSpace * 3),
        child: RHSTForm(
          buttonLabel: "jetzt abmelden",
          onSubmit: (values) => Navigator.of(context, rootNavigator: true).pop(values),
          children: [
            Text(
              "vom nächsten Bereitschaftsdienst abmelden",
              style: Styles.subHeadline.copyWith(color: RHSTColors.primary[700]),
              textAlign: TextAlign.center,
            ),
            const RHSTSpacer(5),
            const RHSTDateTimeSelection(name: "dateTime"),
          ],
        ),
      ),
    );
  }
}
