import 'package:flutter/material.dart';
import 'package:movie_app/providers/movies.provider.dart';

import 'package:movie_app/router/_router.dart';
import 'package:movie_app/theme/app.theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

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

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(_) => MoviesProvider(), lazy: false,)
      ],
      child: const MyApp(),
    );
  }
}