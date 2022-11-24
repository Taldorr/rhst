import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'rhst_spacer.dart';

// Reuasble component that handles basic validation and reduces code duplication
class RHSTForm extends StatefulWidget {
  final String buttonLabel;
  final List<Widget> children;
  final Map<String, dynamic> initialValues;
  final void Function(Map<String, dynamic> values) onSubmit;
  final CrossAxisAlignment? crossAxisAlignment;
  const RHSTForm(
      {Key? key,
      required this.children,
      this.initialValues = const {},
      required this.onSubmit,
      this.crossAxisAlignment,
      required this.buttonLabel})
      : super(key: key);

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
        crossAxisAlignment: widget.crossAxisAlignment ?? CrossAxisAlignment.center,
        children: [
          ...widget.children,
          const RHSTSpacer(5),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _validateAndSubmitData,
                  child: Text(widget.buttonLabel),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
