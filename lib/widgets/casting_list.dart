import 'package:flutter/material.dart';
import 'package:movie_app/models/_models.dart';
import 'package:movie_app/providers/movies.provider.dart';
import 'package:provider/provider.dart';

class CastingList extends StatelessWidget {

  final int movieId;
   
  const CastingList({
    Key? key, required this.movieId
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getCredits(movieId),
      builder: ( _, AsyncSnapshot<List<Cast>> snapshot) {

        if (!snapshot.hasData) {
          return const SizedBox(
            width: double.infinity,
            height: 180,
            child: Center(
              child: CircularProgressIndicator.adaptive()
            )
          );
        }

        final List<Cast> cast = snapshot.data!;

        return Container(
          margin: const EdgeInsets.only( bottom: 30),
          width: double.infinity,
          height: 200,
          child: ListView.builder(
            itemCount: cast.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) => _CastCard(cast[index])
          ),
        );
      }
    );
  }
}

class _CastCard extends StatelessWidget {

  final Cast actor;

  const _CastCard(this.actor);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 180,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(actor.fullProfilePath),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
