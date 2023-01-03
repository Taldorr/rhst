import 'package:flutter/material.dart';
import 'package:rhst/constants.dart';
import 'package:rhst/styles.dart';
import 'package:rhst/widgets/rhst_datetime_selection.dart';
import 'package:rhst/widgets/rhst_form.dart';
import 'package:rhst/widgets/rhst_spacer.dart';
import 'package:rhst/widgets/rhst_switch.dart';

class AttendanceDialog extends StatefulWidget {
  const AttendanceDialog({Key? key}) : super(key: key);

  @override
  State<AttendanceDialog> createState() => _AttendanceDialogState();
}

class _AttendanceDialogState extends State<AttendanceDialog> {
  bool onlyDays = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(Constants.defaultSpace * 3),
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
            FittedBox(
              child: Text(
                "vom nächsten\nBereitschaftsdienst\nabmelden",
                style: Styles.headline,
                textAlign: TextAlign.center,
              ),
            ),
            const RHSTSpacer(5),
            Row(
              children: [
                Expanded(
                  child: RHSTDateTimeSelection(
                    name: "from",
                    onlyDays: onlyDays,
                    iconImage: const AssetImage("assets/icons/arrow_out.png"),
                  ),
                ),
                const RHSTSpacer(2),
                Expanded(
                  child: RHSTDateTimeSelection(
                    name: "until",
                    onlyDays: onlyDays,
                    iconImage: const AssetImage("assets/icons/arrow_in.png"),
                    initialValue: DateTime.now().add(const Duration(days: 1)),
                    isEndSelection: true,
                  ),
                ),
              ],
            ),
            const RHSTSpacer(2),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RHSTSwitch(
                  isActive: onlyDays,
                  label: "ganztägig",
                  onChange: () => setState(() => onlyDays = !onlyDays),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
