import 'package:client/core/models/user_model.dart';
import 'package:client/core/theme/theme.dart';
import 'package:client/core/view/screens/splash_screen.dart';
import 'package:client/features/auth/view/screens/log_in_screen.dart';
import 'package:client/features/auth/view/screens/sign_up_screen.dart';
import 'package:client/core/view_model/auth_view_model.dart';
import 'package:client/features/home/view/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await initializations();
  runApp(const ProviderScope(child: AuthApp()));
}

Future<void> initializations() async {
  // Register Adapters
  Hive.registerAdapter(UserModelAdapter());

  await Hive.initFlutter();
  await Hive.openBox<UserModel>('auth_user');
  await Hive.openBox<String>('auth_token');
}

class AuthApp extends ConsumerStatefulWidget {
  const AuthApp({super.key});

  @override
  ConsumerState<AuthApp> createState() => _AuthAppState();
}

class _AuthAppState extends ConsumerState<AuthApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authViewModelProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auth',
      theme: authTheme,
      routes: {
        SplashScreen.route: (context) => const SplashScreen(),
        SignUpScreen.route: (context) => const SignUpScreen(),
        LogInScreen.route: (context) => const LogInScreen(),
        HomeScreen.route: (context) => const HomeScreen(),
      },
      initialRoute: SplashScreen.route,
    );
  }
}
