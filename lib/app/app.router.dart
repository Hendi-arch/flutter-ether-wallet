// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';

import '../ui/views/inside/home/home_view.dart';
import '../ui/views/outside/signup/signup_view.dart';
import '../ui/views/startup/start_up_view.dart';

class Routes {
  static const String startUpView = '/';
  static const String homeView = 'home';
  static const String signUpView = 'signup';
  static const all = <String>{
    startUpView,
    homeView,
    signUpView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startUpView, page: StartUpView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.signUpView, page: SignUpView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    StartUpView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => StartUpView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const HomeView(),
        settings: data,
      );
    },
    SignUpView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const SignUpView(),
        settings: data,
      );
    },
  };
}
