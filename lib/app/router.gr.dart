// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';

import '../ui/home_view.dart';
import '../ui/stacked_views/events/stacked_events_view.dart';
import '../ui/stacked_views/login/stacked_login_view.dart';

class Routes {
  static const String homeView = '/';
  static const String stackedLoginView = '/stacked-login-view';
  static const String stackedEventsView = '/stacked-events-view';
  static const all = <String>{
    homeView,
    stackedLoginView,
    stackedEventsView,
  };
}

class AutoRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.stackedLoginView, page: StackedLoginView),
    RouteDef(Routes.stackedEventsView, page: StackedEventsView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    HomeView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => HomeView(),
        settings: data,
      );
    },
    StackedLoginView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => StackedLoginView(),
        settings: data,
      );
    },
    StackedEventsView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => StackedEventsView(),
        settings: data,
      );
    },
  };
}
