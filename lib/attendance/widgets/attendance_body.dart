import 'package:flutter/material.dart';
import 'package:rhst/attendance/bloc/bloc.dart';
import 'package:rhst/auth/auth.dart';
import 'package:rhst/constants.dart';
import 'package:rhst/styles.dart';
import 'package:rhst/widgets/rhst_appbar.dart';
import 'package:rhst/widgets/rhst_card.dart';
import 'package:rhst/widgets/rhst_primary_button.dart';
import 'package:rhst/widgets/rhst_spacer.dart';

import 'attendance_dialog.dart';
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
      if (currentUserId != null && values != null) {
        context
            .read<AttendanceBloc>()
            .cancelAttendance(currentUserId, values["from"], values["until"]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        final attendances = state.attendances;
        return Column(
          children: [
            const RHSTAppBar(),
            const RHSTSpacer(3),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Constants.defaultSpace * 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RHSTCard(
                      inverse: true,
                      paddingAll: Constants.defaultSpace * 3,
                      child: Column(
                        children: [
                          FittedBox(child: Text("Bereitschaftsdienst", style: Styles.headline)),
                          //TODO
                          FittedBox(
                            child: Text(
                              "nächste Bereitschaft:\nxxxxxxxx-xxxxxx",
                              style: Styles.subHeadline.copyWith(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const RHSTSpacer(3),
                    Text(
                      "aktuelle Verfügbarkeit",
                      style: Styles.paragraph,
                    ),
                    const RHSTSpacer(1.5),
                    Expanded(
                      child: RHSTCard(
                        inverse: true,
                        padding: const EdgeInsets.symmetric(
                          vertical: Constants.defaultSpace * 1,
                          horizontal: Constants.defaultSpace * 2,
                        ),
                        child: RefreshIndicator(
                          onRefresh: () => _onRefresh(context),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: attendances.length,
                            itemBuilder: (context, index) =>
                                AttendanceListElement(attendance: attendances[index]),
                          ),
                        ),
                      ),
                    ),
                    const RHSTSpacer(3),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Constants.defaultSpace * 4),
                      child: RHSTPrimaryButton(
                        icon: Icons.close,
                        label: "Ich kann leider nicht!",
                        onPressed: () => _cancelAttendance(context),
                      ),
                    ),
                    const RHSTSpacer(3),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
