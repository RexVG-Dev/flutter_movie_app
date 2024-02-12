import 'package:flutter/material.dart';

import 'package:movie_app/theme/app.theme.dart';
import 'package:movie_app/widgets/_widgets.dart';

class DetailsScreen extends StatelessWidget {
   
  const DetailsScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),

          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(),

              _OverView(),
              _OverView(),
              _OverView(),
              _OverView(),

              const CastingList(),
            ])
          ),
        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {

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
          padding: const EdgeInsets.only(bottom: 10),
          color: Colors.black12,
          child: const Text(
            'movie.title',
            style: TextStyle( fontSize: 18),
          ),
        ),
        background: const FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage('https://via.placeholder.com/500x300'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric( horizontal: 20 ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const FadeInImage(
              height: 150,
              fit: BoxFit.cover,
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage('https://via.placeholder.com/200x300')
            ),
          ),

          const SizedBox(width: 20),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'movie.title',
                style: textTheme.headlineMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),

              Text(
                'movie.originalTitle',
                style: textTheme.titleSmall,
                overflow: TextOverflow.ellipsis,
              ),

              Row(
                children: [
                  const Icon(Icons.star_rate_rounded, size: 20, color: Apptheme.secondary,),

                  const SizedBox(width: 5),

                  Text(
                    'movie.voteAverage',
                    style: textTheme.bodySmall,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _OverView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric( horizontal: 30, vertical: 10),
      child: Text(
        'Exercitation amet incididunt laboris enim voluptate commodo voluptate ea irure pariatur. Nisi officia mollit dolor ullamco amet. Sit culpa excepteur fugiat consequat minim in. Nisi tempor exercitation adipisicing anim ad laborum quis nisi ad Lorem ullamco.',
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}