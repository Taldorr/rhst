import 'package:control_style/decorated_input_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:rhst/styles.dart';

class RHSTTextInput extends StatelessWidget {
  final String name;
  final String hint;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final void Function(String?)? onSubmitted;
  final bool obscureText;

  const RHSTTextInput({
    Key? key,
    required this.name,
    required this.hint,
    this.textInputAction,
    this.validator,
    this.onSubmitted,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      textInputAction: textInputAction ?? TextInputAction.done,
      onSubmitted: onSubmitted,
      validator: validator,
      obscureText: obscureText,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: RHSTColors.neutral[800],
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        hintStyle: TextStyle(
          color: RHSTColors.neutral[500],
          fontSize: 16,
        ),
        hintText: hint,
        fillColor: RHSTColors.neutral[100],
        filled: true,
        border: DecoratedInputBorder(
          child: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: Styles.borderRadiusInput,
          ),
          shadow: Styles.rhstOuterShadows,
        ),
      ),
    );
  }
}
