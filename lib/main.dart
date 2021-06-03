import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:basic_services/basic_services.dart';
import 'app/app.locator.dart';
import 'app/my_app.dart';

void main() async {
  // ensure flutter is initialize
  WidgetsFlutterBinding.ensureInitialized();

  // register all dependencies
  final _sharedPreferencesService = await SharedPreferencesService.getInstance();
  locator.registerLazySingleton<SharedPreferencesService>(() => _sharedPreferencesService);
  setupLocator();

  // lock app to portrait orientation & run the app
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) => runApp(MyApp()));
}