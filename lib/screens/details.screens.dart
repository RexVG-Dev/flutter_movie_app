import 'package:flutter/material.dart';
import 'package:movie_app/models/_models.dart';

import 'package:movie_app/theme/app.theme.dart';
import 'package:movie_app/widgets/_widgets.dart';

class DetailsScreen extends StatelessWidget {
   
  const DetailsScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(title: movie.title, backdropPath: movie.fullBackdropPath,),

          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(movie),

              // TODO: integrate the genres tags

              const SizedBox(height: 5),

              _OverView(movie.overview),
              const SizedBox(height: 5),

              CardList(movieId: movie.id, titleList: 'Casting',),
              // CardList(movieId: movie.id, titleList: 'Productoras',),

              // add slider for production_companies by details endpoint
            ])
          ),
        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  final String backdropPath;
  final String title;

  const _CustomAppBar({
    required this.backdropPath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Apptheme.secondary,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10, right: 5, left: 5),
          color: Colors.black12,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle( fontSize: 18),
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(backdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  final Movie movie;

  const _PosterAndTitle(this.movie);

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric( horizontal: 20 ),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                height: 150,
                fit: BoxFit.cover,
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg)
              ),
            ),
          ),

          const SizedBox(width: 20),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: textTheme.headlineMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
            
                Text(
                  movie.originalTitle,
                  style: textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                ),
            
                Row(
                  children: [
                    const Icon(Icons.star_rate_rounded, size: 20, color: Apptheme.secondary,),
            
                    const SizedBox(width: 5),
            
                    Text(
                      movie.voteAverage.toString(),
                      style: textTheme.bodySmall,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _OverView extends StatelessWidget {

  final String overview;

  const _OverView(this.overview);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric( horizontal: 30, vertical: 10),
      child: Text(
        overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}