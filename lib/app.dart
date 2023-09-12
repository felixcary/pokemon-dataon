import 'package:fluro/fluro.dart';
import 'package:pokemon/config/routes/route_config.dart';

class App {
  static App? _instance;

  late FluroRouter router;

  App._internal();

  factory App() {
    _instance ??= App._internal();

    return _instance!;
  }

  Future<void> init() async {
    router = FluroRouter();
    RouteConfig.configureRoutes(router);
  }
}
