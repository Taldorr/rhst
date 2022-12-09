import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:rhst/auth/auth.dart';
import 'package:rhst/constants.dart';
import 'package:rhst/styles.dart';
import 'package:rhst/widgets/rhst_form.dart';
import 'package:rhst/widgets/rhst_scrollable_page_wrapper.dart';
import 'package:rhst/widgets/rhst_text_input.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const ForgotPasswordPage());
  }

  void _onSubmit(BuildContext context, Map<String, dynamic> values) {
    FocusManager.instance.primaryFocus?.unfocus();
    context.read<AuthBloc>().add(ResetPasswordAuthEvent(email: values["email"]));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return RHSTScrollablePageWrapper(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Constants.defaultSpace * 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: Styles.rhstLogoShadows,
              ),
              child: Image.asset("assets/rhst_logo_transparent.png"),
            ),
            Column(
              children: [
                RHSTForm(
                  onSubmit: (values) => _onSubmit(context, values),
                  buttonLabel: "Reset Password",
                  children: [
                    RHSTTextInput(
                      name: "email",
                      hint: "Email",
                      textInputAction: TextInputAction.next,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                      ]),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    "Zurück",
                    style: Styles.light,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
