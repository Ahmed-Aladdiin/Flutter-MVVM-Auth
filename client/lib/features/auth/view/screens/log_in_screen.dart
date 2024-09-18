import 'package:client/features/auth/view/widget/auth_button.dart';
import 'package:client/features/auth/view/widget/auth_input_field.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  static const String route = '/log-in';

  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<LogInScreen> {
  late TextEditingController emailController;
  late TextEditingController passController;
  static const String screenTitle = 'Log In';

  @override
  void initState() {
    super.initState();
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
              '$screenTitle.',
              style: TextStyle(fontSize: 60),
            ),
            const SizedBox(height: 20),
            AuthInputField(controller: emailController, hint: 'Email'),
            const SizedBox(height: 20),
            AuthInputField(controller: passController, hint: 'Password'),
            const SizedBox(height: 23),
            AuthButton(onPressed: () {}, label: screenTitle),
          ],
        ),
      ),
    );
  }
}
