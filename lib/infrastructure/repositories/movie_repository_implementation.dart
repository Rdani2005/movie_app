import 'package:movie_app/domain/datasources/movies_datasource.dart';
import 'package:movie_app/domain/entities/movie.dart';
import 'package:movie_app/domain/repositories/movies_repository.dart';

class MovieRepositoryImplementation extends MovieRepository {
  final MovieDatasource datasource;

  MovieRepositoryImplementation({required this.datasource});

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getCommingSoon({int page = 1}) {
    return datasource.getCommingSoon(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);
  }

  @override
  Future<Movie> getMovieByMovieId({required String movieId}) {
    return datasource.getMovieByMovieId(movieId: movieId);
  }
}
