import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/domain/entities/actor.dart';
import 'package:movie_app/presentation/providers/actors/actors_repository_provider.dart';

typedef GetActorsByMovieCallback = Future<List<Actor>> Function(
    {required String movieId});

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsByMovieCallback getActorsByMovieCallBack;
  ActorsByMovieNotifier({required this.getActorsByMovieCallBack}) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;
    final actors = await getActorsByMovieCallBack(movieId: movieId);
    state = {...state, movieId: actors};
  }
}

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>(
        (ref) {
  final actorsRepo = ref.watch(actorsRepositoryProvider);
  return ActorsByMovieNotifier(
      getActorsByMovieCallBack: actorsRepo.getActorsByMovie);
});
