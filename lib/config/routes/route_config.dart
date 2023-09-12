import 'package:fluro/fluro.dart';
import 'package:pokemon/config/routes/app_routes.dart';

class RouteConfig {
  static void configureRoutes(FluroRouter router) {
    homeViewRoute.define(router);
    authViewRoute.define(router);
  }
}
