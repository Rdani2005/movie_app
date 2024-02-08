import 'package:dio/dio.dart';
import 'package:movie_app/config/constants/environment.dart';
import 'package:movie_app/domain/datasources/movies_datasource.dart';
import 'package:movie_app/domain/entities/movie.dart';
import 'package:movie_app/infrastructure/mappers/movie_mapper.dart';
import 'package:movie_app/infrastructure/models/models.dart';
import 'package:movie_app/infrastructure/models/moviedb_response.dart';

class MovieDBDatasource extends MovieDatasource {
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
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    return await _getMovies(page: page, route: '/movie/now_playing');
  }

  @override
  Future<List<Movie>> getCommingSoon({int page = 1}) async {
    return await _getMovies(page: page, route: '/movie/upcoming');
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    return await _getMovies(page: page, route: '/movie/popular');
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    return await _getMovies(page: page, route: '/movie/top_rated');
  }

  Future<List<Movie>> _getMovies({int page = 1, String route = ''}) async {
    final response = await dio.get(route, queryParameters: {'page': page});
    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDbToEntity(moviedb))
        .toList();

    return movies;
  }

  @override
  Future<Movie> getMovieByMovieId({required String movieId}) async {
    final response = await dio.get('/movie/$movieId');
    if (response.statusCode != 200) {
      throw Exception('Movie with id: $movieId was not found.');
    }
    final movieDBResponse = MovieDbDetails.fromJson(response.data);
    return MovieMapper.movieDBDetailsToEntity(movieDBResponse);
  }
}
