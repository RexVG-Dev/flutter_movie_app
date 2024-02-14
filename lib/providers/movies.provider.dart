

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movie_app/models/_models.dart';

class MoviesProvider extends ChangeNotifier {

  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '122ea4fa1f746994abc9f12c4992a315';
  final String _language = 'es-Es';

  List<Movie> onDisplayMovies = [];

  MoviesProvider(){
    getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    var url =
      Uri.https(_baseUrl, '/3/movie/now_playing', {
        'api_key': _apiKey,
        'language': _language,
        'page': '1'
      });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromRawJson(response.body);

    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }
}