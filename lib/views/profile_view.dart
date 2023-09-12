import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon/app.dart';
import 'package:pokemon/config/routes/app_routes.dart';
import 'package:pokemon/providers/auth_view_provider.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  final String title;

  const ProfileView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthViewProvider>(
      create: (context) => GetIt.I.get<AuthViewProvider>(),
      builder: (context, child) {
        final authViewProvider = Provider.of<AuthViewProvider>(context);
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 24.0),
              ),
              ElevatedButton(
                onPressed: () async {
                  authViewProvider.deleteUserDummyToken();
                  App().router.navigateTo(
                        context,
                        authViewRoute.name,
                        clearStack: true,
                      );
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        );
      },
    );
  }
}
