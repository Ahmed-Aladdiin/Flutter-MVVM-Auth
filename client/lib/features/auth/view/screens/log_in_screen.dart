import 'package:client/core/theme/palette.dart';
import 'package:client/core/utils.dart';
import 'package:client/features/auth/view/screens/sign_up_screen.dart';
import 'package:client/features/auth/view/widget/auth_button.dart';
import 'package:client/features/auth/view/widget/auth_input_field.dart';
import 'package:client/core/view_model/auth_view_model.dart';
import 'package:client/features/auth/view_model/form_validators.dart';
import 'package:client/features/home/view/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogInScreen extends ConsumerStatefulWidget {
  static const String route = '/log-in';

  const LogInScreen({super.key});

  @override
  ConsumerState<LogInScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<LogInScreen> {
  late TextEditingController emailController;
  late TextEditingController passController;
  final formKey = GlobalKey<FormState>();
  static const String screenTitle = 'Log In';

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  void logIn(
    String email,
    String password,
  ) {
    if (!formKey.currentState!.validate()) return;
    ref.read(authViewModelProvider.notifier).logIn(
          email: email,
          password: password,
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authViewModelProvider, (_, state) {
      state?.when(
          data: (data) {
            if(data?.isNotEmpty ?? true) return;
            Navigator.pushNamedAndRemoveUntil(context, HomeScreen.route, (_) => false);
          },
          error: (error, _) {
            snackBarMessage(context, error.toString());
          },
          loading: () {});
    });

    final isLoading = ref.watch(
        authViewModelProvider.select((state) => state?.isLoading ?? false));

    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 180),
              child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        '$screenTitle.',
                        style: TextStyle(fontSize: 60),
                      ),
                      const SizedBox(height: 20),
                      AuthInputField(
                        controller: emailController,
                        hint: 'Email',
                        validator: FormValidators.validateEmail,
                      ),
                      const SizedBox(height: 20),
                      AuthInputField(
                        controller: passController,
                        hint: 'Password',
                        validator: FormValidators.validatePassword,
                        obscureText: true,
                      ),
                      const SizedBox(height: 23),
                      AuthButton(
                          onPressed: () => logIn(
                                emailController.text,
                                passController.text,
                              ),
                          label: screenTitle),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text('Don\'t have an account?'),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, SignUpScreen.route);
                            },
                            child: const Text(
                              'Sign Up.',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Palette.gradient2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ),
          ),
    );
  }
}
