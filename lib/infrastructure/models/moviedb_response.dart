import 'dart:convert';

import 'package:movie_app/infrastructure/models/moviedb.dart';

MovieDbResponse movieDbResponseFromJson(String str) =>
    MovieDbResponse.fromJson(json.decode(str));

String movieDbResponseToJson(MovieDbResponse data) =>
    json.encode(data.toJson());

class MovieDbResponse {
  final int page;
  final List<MovieDB> results;
  final int totalPages;
  final int totalResults;

  MovieDbResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieDbResponse.fromJson(Map<String, dynamic> json) =>
      MovieDbResponse(
        page: json["page"],
        results:
            List<MovieDB>.from(json["results"].map((x) => MovieDB.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
