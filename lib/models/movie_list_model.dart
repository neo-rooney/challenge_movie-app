class MovieListModel {
  final String title, posterPath;
  final int id;

  MovieListModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        posterPath = 'https://image.tmdb.org/t/p/w500${json['poster_path']}',
        id = json['id'];
}
