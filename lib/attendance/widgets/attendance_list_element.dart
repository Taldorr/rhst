import 'package:flutter/material.dart';
import 'package:rhst/constants.dart';
import 'package:rhst/styles.dart';
import 'package:rhst/util/formatter.dart';
import 'package:rhst/widgets/rhst_spacer.dart';

import '../models/attendance.dart';

class AttendanceListElement extends StatelessWidget {
  const AttendanceListElement({
    Key? key,
    required this.attendance,
  }) : super(key: key);

  final Attendance attendance;

  bool _isAvailable(Attendance attendance) {
    if (attendance.notAvailableUntil == null) return true;
    if (attendance.notAvailableFrom == null) return false;
    if (attendance.notAvailableFrom!.toDate().isBefore(DateTime.now()) &&
        attendance.notAvailableUntil!.toDate().isAfter(DateTime.now())) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    bool isAvailable = _isAvailable(attendance);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.defaultSpace * 0.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _displayAvailability(isAvailable),
          const RHSTSpacer(1.5),
          Text(
            attendance.displayName,
            style: Styles.paragraph.copyWith(
              color: RHSTColors.neutral[800],
            ),
          ),
          const Spacer(),
          Text(
            isAvailable ? "" : attendance.notAvailableUntil!.toLocalDayString(),
            style: Styles.footer,
          )
        ],
      ),
    );
  }

  Widget _displayAvailability(bool isAvailable) {
    Color color = isAvailable ? RHSTColors.success[300]! : RHSTColors.error[300]!;

    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
