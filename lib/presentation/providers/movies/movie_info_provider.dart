import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/domain/entities/movie.dart';
import 'package:movie_app/presentation/providers/providers.dart';

typedef GetMovieCallback = Future<Movie> Function({required String movieId});

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovieCallback;
  MovieMapNotifier({required this.getMovieCallback}) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;
    final movie = await getMovieCallback(movieId: movieId);
    state = {...state, movieId: movie};
  }
}

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final movieRepo = ref.watch(movieRepositoryProvider);
  return MovieMapNotifier(getMovieCallback: movieRepo.getMovieByMovieId);
});
