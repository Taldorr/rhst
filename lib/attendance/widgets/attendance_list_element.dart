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

  @override
  Widget build(BuildContext context) {
    bool isAvailable = attendance.notAvailableUntil?.toDate().isBefore(DateTime.now()) ?? true;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.defaultSpace),
      child: Row(
        children: [
          _displayAvailability(isAvailable),
          const RHSTSpacer(1.5),
          Text(attendance.displayName),
          const Spacer(),
          Text(isAvailable ? "" : attendance.notAvailableUntil!.toLocalString())
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
