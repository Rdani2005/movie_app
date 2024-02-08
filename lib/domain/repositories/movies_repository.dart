import 'package:movie_app/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getTopRated({int page = 1});
  Future<List<Movie>> getCommingSoon({int page = 1});
  Future<Movie> getMovieByMovieId({required String movieId});
}
