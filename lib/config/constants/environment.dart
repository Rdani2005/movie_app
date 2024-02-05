import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String movieKey =
      dotenv.env['THE_MOVIE_DB_KEY'] ?? "No Movie API Key provided";
}
