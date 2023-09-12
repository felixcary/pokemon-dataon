import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon/app.dart';
import 'package:pokemon/providers/auth_provider.dart';
import 'package:pokemon/providers/pokemon_detail_provider.dart';
import 'package:pokemon/providers/pokemon_favorite_provider.dart';
import 'package:pokemon/providers/pokemon_provider.dart';
import 'package:pokemon/providers/profile_provider.dart';
import 'package:pokemon/services/api_service.dart';
import 'package:pokemon/services/database_services.dart';
import 'package:pokemon/views/auth/auth_view.dart';
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
    () => AuthProvider(
      databaseService: getIt.get<DatabaseService>(),
    ),
  );
  getIt.registerFactory(
    () => PokemonProvider(
      apiService: getIt.get<ApiService>(),
      databaseService: getIt.get<DatabaseService>(),
    ),
  );
  getIt.registerFactory(
    () => PokemonDetailProvider(
      apiService: getIt.get<ApiService>(),
      databaseService: getIt.get<DatabaseService>(),
    ),
  );
  getIt.registerFactory(
    () => PokemonFavoriteProvider(
      databaseService: getIt.get<DatabaseService>(),
    ),
  );
  getIt.registerFactory(
    () => ProfileProvider(
      databaseService: getIt.get<DatabaseService>(),
    ),
  );
}

class PokemonApp extends StatelessWidget {
  const PokemonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider<AuthProvider>(
        create: (context) => GetIt.I.get<AuthProvider>(),
        builder: (context, child) {
          final authProvider = Provider.of<AuthProvider>(context);
          return FutureBuilder(
            future: authProvider.getUserDummyToken(),
            builder: (context, snapshot) {
              if (authProvider.token.isNotEmpty) {
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
