import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/_models.dart';

class MoviesProvider extends ChangeNotifier {

  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '122ea4fa1f746994abc9f12c4992a315';
  final String _language = 'es-Es';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  MoviesProvider(){
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1] ) async {
    var url =
      Uri.https(_baseUrl, endpoint, {
        'api_key': _apiKey,
        'language': _language,
        'page': '$page'
      }
    );
    
    final response = await http.get(url);
    return response.body;
  
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('/3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromRawJson(jsonData);

    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final jsonData = await _getJsonData('/3/movie/popular', _popularPage);
    final popularMoviesResponse = PopularMoviesResponse.fromRawJson(jsonData);

    popularMovies = [...popularMovies, ...popularMoviesResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getCredits(int movieId) async {
    if( moviesCast.containsKey(movieId) ) return moviesCast[movieId]!;

    final reponse = await _getJsonData('/3/movie/$movieId/credits');
    final creditsMovieResponse = CreditsMovieReponse.fromJson(reponse);

    moviesCast[movieId] = creditsMovieResponse.cast;

    return creditsMovieResponse.cast;
  }
}