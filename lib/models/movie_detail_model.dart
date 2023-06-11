class MovieDetailModel {
  final String title, overview;
  final int id, runtime;
  final List<dynamic> genres;
  final double voteAverage;

  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        overview = json['overview'],
        runtime = json['runtime'],
        genres = json['genres'],
        voteAverage = json['vote_average'],
        id = json['id'];
}
