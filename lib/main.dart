import 'package:flutter/material.dart';

import 'package:movie_app/router/_router.dart';
import 'package:movie_app/theme/app.theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies App',
      initialRoute: AppRoutes.initialRoute,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      routes: AppRoutes.routes,
      theme: Apptheme.lightTheme,
    );
  }
}
