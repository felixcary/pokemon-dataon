import 'package:fluro/fluro.dart';

class RouteMap {
  String name;
  Handler handler;
  TransitionType transitionType;

  RouteMap(
    this.name,
    this.handler, {
    this.transitionType = TransitionType.native,
  });

  void define(FluroRouter router) {
    router.define(
      name,
      handler: handler,
      transitionType: transitionType,
    );
  }
}
