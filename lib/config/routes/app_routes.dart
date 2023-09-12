import 'package:fluro/fluro.dart';
import 'package:pokemon/config/routes/route_map.dart';
import 'package:pokemon/views/auth_view.dart';
import 'package:pokemon/views/home_view.dart';

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
