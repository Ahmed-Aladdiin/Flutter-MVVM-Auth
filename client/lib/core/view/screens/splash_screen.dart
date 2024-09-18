import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const String route = '/splash';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const size = 180.0;
    return Scaffold(
      // appBar: AppBar(),
      body: Center(
        child: SizedBox(
          width: size,
          height: size,
          child: CircleAvatar(
            backgroundColor: Colors.black,
            child: SizedBox(
              width: size * 0.94,
              height: size * 0.94,
              child: Image.asset(
                'assets/imgs/insta.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
