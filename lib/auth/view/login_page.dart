import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:rhst/auth/auth.dart';
import 'package:rhst/constants.dart';
import 'package:rhst/styles.dart';
import 'package:rhst/widgets/rhst_form.dart';
import 'package:rhst/widgets/rhst_scrollable_page_wrapper.dart';
import 'package:rhst/widgets/rhst_spacer.dart';
import 'package:rhst/widgets/rhst_text_input.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const LoginPage());
  }

  void _onSubmit(BuildContext context, Map<String, dynamic> values) {
    FocusManager.instance.primaryFocus?.unfocus();
    context
        .read<AuthBloc>()
        .add(LoginAuthEvent(email: values["email"], password: values["password"]));
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
                  initialValues: FlavorConfig.instance.variables["loginValues"] ?? {},
                  onSubmit: (values) => _onSubmit(context, values),
                  buttonLabel: "Login",
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
                    const RHSTSpacer(3),
                    RHSTTextInput(
                      name: "password",
                      hint: "Passwort",
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(8),
                      ]),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pushNamed("forgot-password"),
                  child: Text(
                    "Passwort vergessen?",
                    style: Styles.light,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
