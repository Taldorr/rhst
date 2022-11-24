import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:rhst/auth/auth.dart';
import 'package:rhst/constants.dart';
import 'package:rhst/widgets/rhst_form.dart';

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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Constants.defaultSpace),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset("assets/logo.png"),
                RHSTForm(
                  initialValues: FlavorConfig.instance.variables["loginValues"] ?? {},
                  onSubmit: (values) => _onSubmit(context, values),
                  buttonLabel: "Login",
                  children: [
                    FormBuilderTextField(
                      name: "email",
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(hintText: "Email-Adresse"),
                      validator: FormBuilderValidators.required(),
                    ),
                    FormBuilderTextField(
                      name: "password",
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                      decoration: const InputDecoration(hintText: "********"),
                      obscureText: true,
                      validator: FormBuilderValidators.minLength(8),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pushNamed("forgot-password"),
                  child: const Text("Passwort vergessen?"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
