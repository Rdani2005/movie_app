import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/infrastructure/data_source/moviedb_actors_datasource.dart';
import 'package:movie_app/infrastructure/repositories/actors_repository_implementation.dart';

final actorsRepositoryProvider = Provider(
  // ? Inmutable
  (ref) {
    return ActorsRepositoryImpl(datasource: MovieDBActorsDataSource());
  },
);
