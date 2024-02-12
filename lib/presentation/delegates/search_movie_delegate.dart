import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/config/helpers/human_formats.dart';
import 'package:movie_app/domain/entities/movie.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(
    {required String query});

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;
  final List<Movie> initialMovies;

  SearchMovieDelegate({
    required this.searchMovies,
    required this.initialMovies,
  });

  StreamController<List<Movie>> debounceMovies = StreamController.broadcast();
  Timer? _debounceTimer;

  void _onQueryChanged(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final movies = await searchMovies(query: query);
      debounceMovies.add(movies);
    });
  }

  void clearStreams() {
    debounceMovies.close();
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }
  }

  @override
  String? get searchFieldLabel => "Search Movie";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeInRight(
        animate: query.isNotEmpty,
        child: IconButton(
          onPressed: () => query = '',
          icon: const Icon(Icons.clear),
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder(
      stream: debounceMovies.stream,
      // future: searchMovies(query: query),
      initialData: initialMovies,
      builder: (context, snapshot) {
        final movies = snapshot.data;
        return ListView.builder(
            itemCount: movies?.length ?? 0,
            itemBuilder: (context, index) {
              final movie = movies![index];
              return _MovieItem(
                movie: movie,
                onMovieSelected: close,
              );
            });
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return StreamBuilder(
      stream: debounceMovies.stream,
      // future: searchMovies(query: query),
      initialData: initialMovies,
      builder: (context, snapshot) {
        final movies = snapshot.data;
        return ListView.builder(
            itemCount: movies?.length ?? 0,
            itemBuilder: (context, index) {
              final movie = movies![index];
              return _MovieItem(
                movie: movie,
                onMovieSelected: close,
              );
            });
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;
  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => onMovieSelected(context, movie),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(children: [
          SizedBox(
            width: size.width * 0.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                movie.posterPath,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const CircularProgressIndicator(strokeWidth: 2);
                  }
                  return FadeIn(child: child);
                },
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: textStyles.titleMedium,
                ),
                (movie.overview.length > 100)
                    ? Text('${movie.overview.substring(0, 100)}...')
                    : Text(movie.overview),
                Row(
                  children: [
                    Icon(
                      Icons.star_half_outlined,
                      color: Colors.yellow.shade800,
                    ),
                    Text(
                      HumanFormats.number(movie.voteAverage, decimals: 2),
                      style: textStyles.bodyMedium!
                          .copyWith(color: Colors.yellow.shade900),
                    )
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
