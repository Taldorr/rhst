import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:rhst/constants.dart';
import 'package:rhst/styles.dart';
import 'package:rhst/widgets/rhst_spacer.dart';

class RHSTDateTimeSelection extends StatelessWidget {
  final String name;
  final DateTime? initialValue;
  const RHSTDateTimeSelection({Key? key, required this.name, this.initialValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<DateTime>(
      name: name,
      initialValue: initialValue ?? DateTime.now(),
      builder: (field) => Column(
        children: [
          Text(
            DateFormat("MMMM", "de_DE").format(field.value!),
            style: Styles.paragraph,
          ),
          const RHSTSpacer(1),
          _buildDays(field.value!, 7),
        ],
      ),

      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   children: [
      //     Column(
      //       children: [
      //         IconButton(
      //           onPressed: () => field.didChange(field.value!.add(const Duration(days: 1))),
      //           icon: const Icon(Icons.arrow_drop_up_rounded),
      //         ),
      //         Text(DateFormat("dd.MM.yyyy").format(field.value ?? DateTime.now())),
      //         IconButton(
      //           onPressed: () => field.didChange(field.value!.subtract(const Duration(days: 1))),
      //           icon: const Icon(Icons.arrow_drop_down_rounded),
      //         ),
      //       ],
      //     ),
      //     Column(
      //       children: [
      //         IconButton(
      //           onPressed: () => field.didChange(field.value!.add(const Duration(hours: 1))),
      //           icon: const Icon(Icons.arrow_drop_up_rounded),
      //         ),
      //         Text("${DateFormat("HH:00").format(field.value ?? DateTime.now())} Uhr"),
      //         IconButton(
      //           onPressed: () => field.didChange(field.value!.subtract(const Duration(hours: 1))),
      //           icon: const Icon(Icons.arrow_drop_down_rounded),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
    );
  }

  Widget _buildDays(DateTime start, int days) {
    List<Widget> result = [];
    for (var i = 0; i < days; i++) {
      final date = start.add(Duration(days: i));
      result.add(_buildDay(DateFormat("dd", "de_DE").format(date)));
      result.add(const RHSTSpacer(1));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: result,
    );
  }

  Widget _buildDay(String text) => Container(
        padding: const EdgeInsets.all(Constants.defaultSpace),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: Styles.rhstOuterShadows,
          color: RHSTColors.neutral[200],
        ),
        child: Text(text),
      );
}
