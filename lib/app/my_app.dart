import 'package:flutter/material.dart';
import 'package:basic_services/basic_services.dart';
import 'package:flutter_smart_contract/app/app.router.dart';
import 'package:flutter_smart_contract/core/constant/constant.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: APP_TITLE,
        navigatorKey: StackedService.navigatorKey,
        navigatorObservers: [StackedService.routeObserver],
        onGenerateRoute: (RouteSettings settings) => StackedRouter().onGenerateRoute(settings),
        builder: (context, child) =>
            MediaQuery(child: child!, data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0)));
  }
}
