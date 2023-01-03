import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:rhst/widgets/rhst_primary_button.dart';

import 'rhst_spacer.dart';

// Reuasble component that handles basic validation and reduces code duplication
class RHSTForm extends StatefulWidget {
  final String buttonLabel;
  final List<Widget> children;
  final Map<String, dynamic> initialValues;
  final void Function(Map<String, dynamic> values) onSubmit;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  final Widget? secondaryButton;
  const RHSTForm({
    Key? key,
    required this.children,
    this.initialValues = const {},
    required this.onSubmit,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    required this.buttonLabel,
    this.secondaryButton,
  }) : super(key: key);

  @override
  State<RHSTForm> createState() => _RHSTFormState();
}

class _RHSTFormState extends State<RHSTForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  bool _didTrySubmit = false;

  void _validateAndSubmitData() async {
    final isValid = _formKey.currentState?.saveAndValidate() ?? false;
    setState(() => _didTrySubmit = true);
    if (!isValid) return;

    widget.onSubmit(_formKey.currentState!.value);
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      initialValue: widget.initialValues,
      autoFocusOnValidationFailure: true,
      autovalidateMode:
          _didTrySubmit ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.start,
        crossAxisAlignment: widget.crossAxisAlignment ?? CrossAxisAlignment.center,
        children: [
          ...widget.children,
          const RHSTSpacer(5),
          if (widget.secondaryButton != null)
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(child: widget.secondaryButton!),
              ],
            ),
          if (widget.secondaryButton != null) const RHSTSpacer(2),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: RHSTPrimaryButton(
                onPressed: _validateAndSubmitData,
                label: widget.buttonLabel,
                icon: Icons.check,
              )),
            ],
          ),
        ],
      ),
    );
  }
}
