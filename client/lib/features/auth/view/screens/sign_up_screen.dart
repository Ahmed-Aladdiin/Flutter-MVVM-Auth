import 'package:client/core/theme/palette.dart';
import 'package:client/core/utils.dart';
import 'package:client/features/auth/view/widget/auth_button.dart';
import 'package:client/features/auth/view/widget/auth_input_field.dart';
import 'package:client/core/view_model/auth_view_model.dart';
import 'package:client/features/auth/view_model/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static const String route = '/sign-up';

  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  void signUp({
    required String name,
    required String email,
    required String password,
  }) {
    if (!formKey.currentState!.validate()) return;
    ref.read(authViewModelProvider.notifier).signUp(
          name: name,
          email: email,
          password: password,
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authViewModelProvider, (_, state) {
      state?.when(
          data: (msg) {
            snackBarMessage(context, msg ?? 'No message');
            Navigator.pop(context);
          },
          error: (error, _) {
            snackBarMessage(context, error.toString());
          },
          loading: () {});
    });

    final isLoading = ref.watch(
        authViewModelProvider.select((state) => state?.isLoading ?? false));

    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 90),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Sign Up.',
                        style: TextStyle(fontSize: 60),
                      ),
                      const SizedBox(height: 20),
                      AuthInputField(
                        controller: nameController,
                        hint: 'Name',
                        validator: FormValidators.validateName,
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
                          onPressed: () => signUp(
                                name: nameController.text,
                                email: emailController.text,
                                password: passController.text,
                              ),
                          label: 'Sign Up'),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text('Have an account?'),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Log In.',
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
