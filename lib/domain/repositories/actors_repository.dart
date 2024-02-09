import 'package:movie_app/domain/entities/actor.dart';

abstract class ActorsRepository {
  Future<List<Actor>> getActorsByMovie({required String movieId});
}
