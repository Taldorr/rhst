import 'package:control_style/decorated_input_border.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:rhst/styles.dart';
import 'package:rhst/widgets/rhst_spacer.dart';

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
    final depth = NeumorphicTheme.of(context)!.value.theme.depth;
    return FormBuilderField<String>(
      name: name,
      validator: validator,
      onSaved: onSubmitted,
      builder: (field) => Column(
        children: [
          Neumorphic(
            style: NeumorphicStyle(
              depth: field.value?.isEmpty ?? true ? depth : -depth,
            ),
            child: TextField(
              textInputAction: textInputAction ?? TextInputAction.done,
              onChanged: (value) => field.didChange(value),
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
                ),
              ),
            ),
          ),
          const RHSTSpacer(1),
          Text(
            field.errorText ?? "",
            style: Styles.errorText,
          ),
        ],
      ),
    );
  }
}
