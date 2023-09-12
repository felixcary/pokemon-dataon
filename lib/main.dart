import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon/app.dart';
import 'package:pokemon/providers/auth_view_provider.dart';
import 'package:pokemon/providers/pokemon_detail_provider.dart';
import 'package:pokemon/providers/pokemon_provider.dart';
import 'package:pokemon/services/api_service.dart';
import 'package:pokemon/services/database_services.dart';
import 'package:pokemon/views/auth_view.dart';
import 'package:pokemon/views/home_view.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await App().init();
  setupDependencyInjection();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then(
    (value) => runApp(
      const PokemonApp(),
    ),
  );
}

void setupDependencyInjection() {
  final getIt = GetIt.instance;

  getIt.registerLazySingleton(() => ApiService());
  getIt.registerLazySingleton(() => DatabaseService());
  getIt.registerFactory(
    () => AuthViewProvider(
      databaseService: getIt.get<DatabaseService>(),
    ),
  );
  getIt.registerFactory(
    () => PokemonProvider(
      apiService: getIt.get<ApiService>(),
    ),
  );
  getIt.registerFactory(
    () => PokemonDetailProvider(
      apiService: getIt.get<ApiService>(),
    ),
  );
}

class PokemonApp extends StatelessWidget {
  const PokemonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider<AuthViewProvider>(
        create: (context) => GetIt.I.get<AuthViewProvider>(),
        builder: (context, child) {
          final authViewProvider = Provider.of<AuthViewProvider>(context);
          return FutureBuilder(
            future: authViewProvider.getUserDummyToken(),
            builder: (context, snapshot) {
              if (authViewProvider.token.isNotEmpty) {
                return const HomeView();
              }
              return const AuthView();
            },
          );
        },
      ),
      onGenerateRoute: App().router.generator,
    );
  }
}
