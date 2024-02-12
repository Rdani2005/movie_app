import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/domain/entities/movie.dart';
import 'package:movie_app/presentation/providers/providers.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchMoviesProvider =
    StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  final movieRepository = ref.read(movieRepositoryProvider);
  return SearchedMoviesNotifier(
    ref: ref,
    searchMoviesCallback: movieRepository.searchMoviesByQuery,
  );
});

typedef SearchMoviesCallback = Future<List<Movie>> Function(
    {required String query});

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  final SearchMoviesCallback searchMoviesCallback;
  final Ref ref;

  SearchedMoviesNotifier({
    required this.ref,
    required this.searchMoviesCallback,
  }) : super([]);

  Future<List<Movie>> searchMoviesByQuery({required String query}) async {
    final List<Movie> movies = await searchMoviesCallback(query: query);
    ref.read(searchQueryProvider.notifier).update((state) => query);
    state = movies;
    return movies;
  }
}
