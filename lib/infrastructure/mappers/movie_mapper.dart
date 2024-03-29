import 'package:movie_app/domain/entities/movie.dart';
import 'package:movie_app/infrastructure/models/models.dart';

class MovieMapper {
  static Movie movieDbToEntity(MovieDB movieDB) => Movie(
        adult: movieDB.adult,
        backdropPath: movieDB.backdropPath != ''
            ? 'https://image.tmdb.org/t/p/w500${movieDB.backdropPath}'
            : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg',
        genreIds: movieDB.genreIds.map((e) => e.toString()).toList(),
        id: movieDB.id,
        originalLanguage: movieDB.originalLanguage,
        originalTitle: movieDB.originalTitle,
        overview: movieDB.overview,
        popularity: movieDB.popularity,
        posterPath: movieDB.posterPath != ''
            ? 'https://image.tmdb.org/t/p/original${movieDB.posterPath}'
            : 'https://www.joblo.com/wp-content/uploads/2008/09/movie-poster-missing-2.jpg',
        releaseDate: movieDB.releaseDate,
        title: movieDB.title,
        video: movieDB.video,
        voteAverage: movieDB.voteAverage,
        voteCount: movieDB.voteCount,
      );

  static Movie movieDBDetailsToEntity(MovieDbDetails movieDbDetails) {
    return Movie(
      adult: movieDbDetails.adult,
      backdropPath: movieDbDetails.backdropPath != ''
          ? 'https://image.tmdb.org/t/p/w500${movieDbDetails.backdropPath}'
          : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg',
      genreIds: movieDbDetails.genres.map((e) => e.name).toList(),
      id: movieDbDetails.id,
      originalLanguage: movieDbDetails.originalLanguage,
      originalTitle: movieDbDetails.originalTitle,
      overview: movieDbDetails.overview,
      popularity: movieDbDetails.popularity,
      posterPath: movieDbDetails.posterPath != ''
          ? 'https://image.tmdb.org/t/p/original${movieDbDetails.posterPath}'
          : 'no-poster',
      releaseDate: movieDbDetails.releaseDate,
      title: movieDbDetails.title,
      video: movieDbDetails.video,
      voteAverage: movieDbDetails.voteAverage,
      voteCount: movieDbDetails.voteCount,
    );
  }
}
