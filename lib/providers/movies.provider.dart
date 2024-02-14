

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movie_app/models/_models.dart';

class MoviesProvider extends ChangeNotifier {

  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '122ea4fa1f746994abc9f12c4992a315';
  final String _language = 'es-Es';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

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
    final jsonData = await _getJsonData('/3/movie/popula', _popularPage);
    final popularMoviesResponse = PopularMoviesResponse.fromRawJson(jsonData);

    popularMovies = [...popularMovies, ...popularMoviesResponse.results];
    notifyListeners();
  }
}