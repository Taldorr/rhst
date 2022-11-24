import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:rhst/auth/auth.dart';
import 'package:rhst/constants.dart';
import 'package:rhst/widgets/rhst_form.dart';

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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Constants.defaultSpace),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset("assets/logo.png"),
                RHSTForm(
                  onSubmit: (values) => _onSubmit(context, values),
                  buttonLabel: "Reset Password",
                  children: [
                    FormBuilderTextField(
                      name: "email",
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(hintText: "Email-Adresse"),
                      validator: FormBuilderValidators.required(),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Zurück"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
