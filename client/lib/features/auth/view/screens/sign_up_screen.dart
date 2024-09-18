import 'package:client/features/auth/view/widget/auth_button.dart';
import 'package:client/features/auth/view/widget/auth_input_field.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static const String route = '/sign-up';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Sign Up.',
              style: TextStyle(fontSize: 60),
            ),
            const SizedBox(height: 20),
            AuthInputField(controller: nameController, hint: 'Name'),
            const SizedBox(height: 20),
            AuthInputField(controller: emailController, hint: 'Email'),
            const SizedBox(height: 20),
            AuthInputField(controller: passController, hint: 'Password'),
            const SizedBox(height: 23),
            AuthButton(onPressed: () {}, label: 'Sign Up'),
          ],
        ),
      ),
    );
  }
}
