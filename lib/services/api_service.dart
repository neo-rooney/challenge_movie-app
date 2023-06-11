import 'dart:convert';

import 'package:challenge_movie_app/models/movie_detail_model.dart';
import 'package:challenge_movie_app/models/movie_list_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://movies-api.nomadcoders.workers.dev';
  static const String popular = 'popular';
  static const String nowPlaying = 'now-playing';
  static const String comingSoon = 'coming-soon';

  static Future<List<MovieListModel>> getPopularMovies() async {
    List<MovieListModel> movieListInstance = [];
    final url = Uri.parse('$baseUrl/$popular');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var movies = jsonDecode(response.body)["results"];

      for (var item in movies) {
        final movie = MovieListModel.fromJson(item);
        movieListInstance.add(movie);
      }

      return movieListInstance;
    }
    throw Error();
  }

  static Future<List<MovieListModel>> getNowPlayingMovies() async {
    List<MovieListModel> movieListInstance = [];
    final url = Uri.parse('$baseUrl/$nowPlaying');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var movies = jsonDecode(response.body)["results"];

      for (var item in movies) {
        final movie = MovieListModel.fromJson(item);
        movieListInstance.add(movie);
      }

      return movieListInstance;
    }
    throw Error();
  }

  static Future<List<MovieListModel>> getComingSoonMovies() async {
    List<MovieListModel> movieListInstance = [];
    final url = Uri.parse('$baseUrl/$comingSoon');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var movies = jsonDecode(response.body)["results"];

      for (var item in movies) {
        final movie = MovieListModel.fromJson(item);
        movieListInstance.add(movie);
      }

      return movieListInstance;
    }
    throw Error();
  }

  static Future<MovieDetailModel> getToonById(int id) async {
    final url = Uri.parse("$baseUrl/movie?id=$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return MovieDetailModel.fromJson(webtoon);
    }
    throw Error();
  }
}
