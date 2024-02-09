import 'package:dio/dio.dart';
import 'package:movie_app/config/constants/environment.dart';
import 'package:movie_app/domain/datasources/actors_datasource.dart';
import 'package:movie_app/domain/entities/actor.dart';
import 'package:movie_app/infrastructure/mappers/cast_mapper.dart';
import 'package:movie_app/infrastructure/models/models.dart';

class MovieDBActorsDataSource extends ActorsDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.movieKey,
        'language': 'en-US',
      },
    ),
  );

  @override
  Future<List<Actor>> getActorsByMovie({required String movieId}) async {
    final response = await dio.get('/movie/$movieId/credits');
    if (response.statusCode != 200) {
      throw Exception('Movie with id: $movieId was not found.');
    }
    final movieDBResponse = MovieDbCastResponse.fromJson(response.data);
    final actorsResponse =
        movieDBResponse.cast.map((e) => CastMapper.castToActor(e)).toList();
    return actorsResponse;
  }
}
