import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/infrastructure/data_source/moviedb_datasource.dart';
import 'package:movie_app/infrastructure/repositories/movie_repository_implementation.dart';

final movieRepositoryProvider = Provider(
  // ? Inmutable
  (ref) {
    return MovieRepositoryImplementation(datasource: MovieDBDatasource());
  },
);
