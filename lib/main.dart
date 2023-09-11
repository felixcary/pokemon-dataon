import 'package:flutter/material.dart';
import 'package:pokemon/providers/auth_view_provider.dart';
import 'package:pokemon/views/auth_view.dart';
import 'package:pokemon/views/home_view.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider<AuthViewProvider>(
        create: (context) => AuthViewProvider(),
        builder: (context, child) {
          return FutureBuilder(
            future: Provider.of<AuthViewProvider>(context, listen: false)
                .loadUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (Provider.of<AuthViewProvider>(context).email.isNotEmpty) {
                  return const HomeView();
                }
                return const AuthView();
              } else {
                return const CircularProgressIndicator();
              }
            },
          );
        },
      ),
      routes: {
        '/home': (context) {
          return const HomeView();
        },
      },
    );
  }
}
