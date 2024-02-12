import 'package:flutter/material.dart';

import 'package:movie_app/screens/_screens.dart';

class AppRoutes {

  static const initialRoute = 'home';
  // static Map<String, Widget Function(BuildContext)> routes const <String, WidgetBuilder>{}
  static Map<String, Widget Function(BuildContext)> routes = {
    'home': (BuildContext context) => const HomeScreen(),
    'details': (BuildContext context) => const DetailsScreen(),
  };

  static Route<dynamic> onGenerateRoute (RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const HomeScreen()
    );
  }
}
