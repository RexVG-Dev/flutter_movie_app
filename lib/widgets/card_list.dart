import 'package:flutter/material.dart';
import 'package:movie_app/models/_models.dart';
import 'package:movie_app/providers/movies.provider.dart';
import 'package:provider/provider.dart';

class CardList extends StatelessWidget {

  final String titleList;
  final int movieId;
   
  const CardList({
    Key? key,
    required this.movieId,
    required this.titleList,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    final TextTheme textTheme = Theme.of(context).textTheme;

    return FutureBuilder(
      future: moviesProvider.getCredits(movieId),
      builder: ( context, AsyncSnapshot<List<Cast>> snapshot) {

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
          height: 220,
          child: Column(
            children: [

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  titleList,
                  textAlign: TextAlign.left,
                  style: textTheme.titleLarge,
                
                ),
              ),

              const SizedBox(height: 5),
              
               Expanded(
                 child: ListView.builder(
                  itemCount: cast.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) => _CastCard(cast[index])
                ),
               ),
            ],
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
