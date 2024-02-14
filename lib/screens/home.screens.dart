import 'package:flutter/material.dart';
import 'package:movie_app/providers/movies.provider.dart';

import 'package:movie_app/widgets/_widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas en cines'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed:() {
            },
            icon: const Icon( Icons.search_rounded)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
        children: [
          CardSwiper( movies: moviesProvider.onDisplayMovies),

          MovieSlider(
            title: 'Populares',
            movies: moviesProvider.popularMovies,
          ),
        ],
      ),
      )
    );
  }
}