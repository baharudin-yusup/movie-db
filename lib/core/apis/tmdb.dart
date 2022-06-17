import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:movie_db/core/models/movie.dart';

class Api {
  static const _apiKey = 'c0fe60d0e244a4ef696a214967eb645d';
  static const baseApiUrl = 'https://api.themoviedb.org/3';
  static const baseImageUrl = 'https://image.tmdb.org/t/p/original';

  static Future<List<Movie>> get movies async {
    log('get movies...');

    final movies = <Movie>[];

    const url = '$baseApiUrl/discover/movie?page=1&api_key=$_apiKey';
    log('api: $url');
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      return [];
    }

    final results = List<Map<String, dynamic>>.from(jsonDecode(response.body)['results']);
    final genres = await Api.genres;
    for (var raw in results) {
      try {
        List<String> movieGenres = [];
        for (var genreId in raw['genre_ids']) {
          movieGenres.add(genres[genreId] ?? 'Unknown');
        }

        movies.add(Movie(
          genres: movieGenres,
          title: raw['title'],
          releaseDate: raw['release_date'].isEmpty ? null : DateTime.parse(raw['release_date']),
          posterUri: Uri.parse('$baseImageUrl${raw['poster_path']}'),
          backdropUri: Uri.parse('$baseImageUrl${raw['backdrop_path']}'),
          voteAverage:
              raw['vote_average'] is double ? raw['vote_average'] : raw['vote_average'].toDouble(),
          voteCount: raw['vote_count'],
          description: raw['overview'],
        ));
      } catch (e) {
        log('error when trying to adding movie: ${e.toString()}');
        log('data\n: $raw');
      }
    }
    log('total data: ${movies.length}');

    return movies;
  }

  static Future<Map<int, String>> get genres async {
    final Map<int, String> genres = {};
    const url = '$baseApiUrl/genre/movie/list?api_key=$_apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      return {};
    }

    final results = List<Map<String, dynamic>>.from(jsonDecode(response.body)['genres']);

    for (var rawGenre in results) {
      genres[rawGenre['id']] = rawGenre['name'];
    }

    return genres;
  }
}