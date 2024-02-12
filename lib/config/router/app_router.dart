import 'package:go_router/go_router.dart';
import 'package:movie_app/presentation/screens/movies/home_screen.dart';
import 'package:movie_app/presentation/screens/movies/movie_screen.dart';
import 'package:movie_app/presentation/views/views.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // GoRoute(
    //     path: '/',
    //     name: HomeScreen.name,
    //     builder: (_, __) => const HomeScreen(childView: HomeView()),
    //     routes: [
    // GoRoute(
    //   path: 'movie/:id',
    //   name: MovieScreen.name,
    //   builder: (_, state) => MovieScreen(
    //     movieId: state.pathParameters["id"] ?? 'No Id',
    //   ),
    // ),
    //     ]),
    ShellRoute(
        builder: (context, state, child) => HomeScreen(childView: child),
        routes: [
          GoRoute(
              path: '/',
              builder: (context, state) => const HomeView(),
              routes: [
                GoRoute(
                  path: 'movie/:id',
                  name: MovieScreen.name,
                  builder: (_, state) => MovieScreen(
                    movieId: state.pathParameters["id"] ?? 'No Id',
                  ),
                ),
              ]),
          GoRoute(
            path: '/favorites',
            builder: (context, state) => const FavoritesView(),
          ),
        ]),
  ],
);
