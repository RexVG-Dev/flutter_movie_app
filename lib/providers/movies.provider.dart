import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/helpers/debouncer.dart';
import 'package:movie_app/models/_models.dart';
import 'package:movie_app/models/details_movie_response.dart';

class MoviesProvider extends ChangeNotifier {

  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '122ea4fa1f746994abc9f12c4992a315';
  final String _language = 'es-Es';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  final StreamController<List<Movie>> _suggestionsStreamController = StreamController.broadcast();
  Stream<List<Movie>> get suggestionsStream => _suggestionsStreamController.stream;

  MoviesProvider(){
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1] ) async {
    final url =
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
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final jsonData = await _getJsonData('/3/movie/popular', _popularPage);
    final popularMoviesResponse = PopularMoviesResponse.fromJson(jsonData);

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

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_baseUrl, '/3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query
    });

    final response = await http.get(url);
    final searchMoviesResponse = SearchMoviesResponse.fromJson(response.body);

    return searchMoviesResponse.results;
  }

  void getSuggestionsByQuery( String searchValue ) {
    debouncer.value = '';
    debouncer.onValue =(value) async {
      final results = await searchMovies(value);
      _suggestionsStreamController.add(results);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = searchValue;
    });

    Future.delayed(const Duration(milliseconds: 301)).then((_) => timer.cancel());
  }

  Future<DetailsMoviesResponse> getDetailsMovies(int movieId) async {
    final reponse = await _getJsonData('/3/movie/$movieId');
    final detailsMoviesResponse = DetailsMoviesResponse.fromJson(reponse);

    return detailsMoviesResponse;
  }
}