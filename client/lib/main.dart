import 'package:client/core/theme/theme.dart';
import 'package:client/core/view/screens/splash_screen.dart';
import 'package:client/features/auth/view/screens/log_in_screen.dart';
import 'package:client/features/auth/view/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AuthApp());
}

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: authTheme,
      routes: {
        SplashScreen.route: (context) => const SplashScreen(),
        SignUpScreen.route: (context) => const SignUpScreen(),
        LogInScreen.route: (context) => const LogInScreen(),
      },
      initialRoute: SignUpScreen.route,
    );
  }
}
