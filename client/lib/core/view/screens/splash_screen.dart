import 'package:client/core/utils.dart';
import 'package:client/features/auth/view/screens/log_in_screen.dart';
import 'package:client/core/view_model/auth_view_model.dart';
import 'package:client/features/home/view/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerWidget {
  static const String route = '/splash';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authViewModelProvider, (_, state) {
      state?.when(data: (data) {
        if (data != null) {
          Navigator.pushNamedAndRemoveUntil(context, HomeScreen.route, (_) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(context, LogInScreen.route, (_) => false);
        }
      }, error: (error, stackTrace) {
        debugPrint("got the error");
        snackBarMessage(context, error.toString());
      }, loading: () {});
    });

    const size = 180.0;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: size * 0.94,
          height: size * 0.94,
          child: Image.asset(
            'assets/imgs/insta.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
