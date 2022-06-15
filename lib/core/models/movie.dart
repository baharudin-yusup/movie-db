class Movie {
  final String title;
  final String description;
  final DateTime? releaseDate;
  final Uri posterUri;
  final Uri backdropUri;
  final double voteAverage;
  final int voteCount;
  final List<String> genres;

  Movie(
      {required this.title,
      required this.releaseDate,
      required this.description,
      required this.genres,
      required this.posterUri,
      required this.backdropUri,
      required this.voteAverage,
      required this.voteCount});
}
