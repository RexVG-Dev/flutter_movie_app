import 'dart:convert';

import 'package:movie_app/models/_models.dart';

class PopularMoviesResponse {
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  PopularMoviesResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory PopularMoviesResponse.fromRawJson(String str) => PopularMoviesResponse.fromJson(json.decode(str));

  factory PopularMoviesResponse.fromJson(Map<String, dynamic> json) => PopularMoviesResponse(
    page: json["page"],
    results: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );
}
