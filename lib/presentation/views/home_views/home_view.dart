import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/presentation/providers/providers.dart';
import 'package:movie_app/presentation/widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(commingSoonMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return FullScreenLoader();

    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final commingSoonMovies = ref.watch(commingSoonMoviesProvider);

    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          title: CustomAppBar(),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Column(
              children: [
                MoviesSlideShow(movies: slideShowMovies),
                MovieHorizontalListView(
                  movies: nowPlayingMovies,
                  title: "Now Playing",
                  subTitle: "Mon 15th",
                  loadNextPage: () => ref
                      .read(nowPlayingMoviesProvider.notifier)
                      .loadNextPage(),
                ),
                MovieHorizontalListView(
                  movies: popularMovies,
                  title: "Most Popular",
                  subTitle: "this year",
                  loadNextPage: () =>
                      ref.read(popularMoviesProvider.notifier).loadNextPage(),
                ),
                MovieHorizontalListView(
                  movies: topRatedMovies,
                  title: "Top Rated",
                  subTitle: "Forever",
                  loadNextPage: () =>
                      ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
                ),
                MovieHorizontalListView(
                  movies: commingSoonMovies,
                  title: "Comming Soon",
                  subTitle: "Soon",
                  loadNextPage: () => ref
                      .read(commingSoonMoviesProvider.notifier)
                      .loadNextPage(),
                ),
              ],
            );
          },
          childCount: 1,
        ),
      )
    ]);
  }
}
