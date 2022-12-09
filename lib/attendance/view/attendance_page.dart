import 'package:flutter/material.dart';
import 'package:rhst/attendance/bloc/bloc.dart';
import 'package:rhst/attendance/widgets/attendance_body.dart';
import 'package:rhst/widgets/rhst_scrollable_page_wrapper.dart';

import '../repositories/attendance_repository.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AttendanceRepository(),
      child: BlocProvider(
        create: (context) => AttendanceBloc(RepositoryProvider.of<AttendanceRepository>(context))
          ..add(const LoadAttendanceEvent()),
        child: const RHSTScrollablePageWrapper(
          showNavbar: true,
          child: AttendanceBody(),
        ),
      ),
    );
  }
}
