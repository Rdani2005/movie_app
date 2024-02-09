import 'package:movie_app/domain/datasources/actors_datasource.dart';
import 'package:movie_app/domain/entities/actor.dart';
import 'package:movie_app/domain/repositories/actors_repository.dart';

class ActorsRepositoryImpl extends ActorsRepository {
  final ActorsDatasource datasource;

  ActorsRepositoryImpl({required this.datasource});

  @override
  Future<List<Actor>> getActorsByMovie({required String movieId}) {
    return datasource.getActorsByMovie(movieId: movieId);
  }
}
