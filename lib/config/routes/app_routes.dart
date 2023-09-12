import 'package:fluro/fluro.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon/config/routes/route_map.dart';
import 'package:pokemon/providers/pokemon_detail_provider.dart';
import 'package:pokemon/views/auth/auth_view.dart';
import 'package:pokemon/views/auth/sign_in_view.dart';
import 'package:pokemon/views/auth/sign_up_view.dart';
import 'package:pokemon/views/home_view.dart';
import 'package:pokemon/views/pokemon_detail/pokemon_detail_view.dart';
import 'package:provider/provider.dart';

final RouteMap homeViewRoute = RouteMap(
  '/home',
  Handler(
    handlerFunc: (context, Map<String, List<String>> params) {
      return const HomeView();
    },
  ),
);

final RouteMap authViewRoute = RouteMap(
  '/auth',
  Handler(
    handlerFunc: (context, Map<String, List<String>> params) {
      return const AuthView();
    },
  ),
);

final RouteMap signInRoute = RouteMap(
  '/signin',
  Handler(
    handlerFunc: (context, Map<String, List<String>> params) {
      return const SignInView();
    },
  ),
);

final RouteMap signUpRoute = RouteMap(
  '/signup',
  Handler(
    handlerFunc: (context, Map<String, List<String>> params) {
      return const SignUpView();
    },
  ),
);

final RouteMap pokemonDetailRoute = RouteMap(
  'pokemon_detail',
  Handler(
    handlerFunc: (context, params) {
      Map<String, dynamic> data =
          context!.settings!.arguments as Map<String, dynamic>? ?? {};
      String pokemonName = data['pokemonName'] ?? '';

      return ChangeNotifierProvider<PokemonDetailProvider>(
        create: (context) =>
            GetIt.I.get<PokemonDetailProvider>()..getPokemonByName(pokemonName),
        builder: (context, child) {
          return const PokemonDetailView();
        },
      );
    },
  ),
  transitionType: TransitionType.fadeIn,
);
