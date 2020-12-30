import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:state_management_test/app/locator.dart';

import 'app/router.gr.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: AutoRouter().onGenerateRoute,
      initialRoute: Routes.homeView,
    );
  }
}
