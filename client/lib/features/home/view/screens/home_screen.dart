import 'package:client/core/providers/user_provider.dart';
import 'package:client/core/view_model/auth_view_model.dart';
import 'package:client/features/auth/view/screens/log_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  static const String route = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.settings),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  ref.read(authViewModelProvider.notifier).logOut();
                  Navigator.pushNamedAndRemoveUntil(context, LogInScreen.route, (_) => false);
                },
                child: const Row(
                  children: <Widget>[
                    Icon(Icons.exit_to_app_rounded),
                    Text(' Log Out.'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(user?.name ?? 'no name'),
            const SizedBox(height: 20),
            Text(user?.email ?? 'no email'),
          ],
        ),
      ),
    );
  }
}
