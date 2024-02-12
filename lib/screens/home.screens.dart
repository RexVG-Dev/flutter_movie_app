import 'package:flutter/material.dart';

import 'package:movie_app/widgets/_widgets.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
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
      body: const SingleChildScrollView(
        child: Column(
        children: [
          CardSwiper(),

          MovieSlider(),
        ],
      ),
      )
    );
  }
}