import 'dart:convert';

import 'package:movie_app/infrastructure/models/cast_moviedb.dart';

MovieDbCastResponse movieDbCastResponseFromJson(String str) =>
    MovieDbCastResponse.fromJson(json.decode(str));

String movieDbCastResponseToJson(MovieDbCastResponse data) =>
    json.encode(data.toJson());

class MovieDbCastResponse {
  final int id;
  final List<CastMovieDB> cast;
  final List<CastMovieDB> crew;

  MovieDbCastResponse({
    required this.id,
    required this.cast,
    required this.crew,
  });

  factory MovieDbCastResponse.fromJson(Map<String, dynamic> json) =>
      MovieDbCastResponse(
        id: json["id"],
        cast: List<CastMovieDB>.from(
            json["cast"].map((x) => CastMovieDB.fromJson(x))),
        crew: List<CastMovieDB>.from(
            json["crew"].map((x) => CastMovieDB.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
        "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
      };
}
