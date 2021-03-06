import 'dart:convert';

MPaginator movieFromJson(String str) => MPaginator.fromJson(json.decode(str));

class MPaginator {
  MPaginator({
    required this.count,
    required this.next,
    required this.previous,
    required this.movies,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Movie> movies;

  factory MPaginator.fromJson(Map<String, dynamic> json) => MPaginator(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        movies: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<Movie>.from(movies.map((x) => x.toJson())),
      };
}

class Movie {
  Movie({
    required this.title,
    required this.episodeId,
    required this.openingCrawl,
    required this.director,
    required this.producer,
    required this.releaseDate,
  });

  String title;
  int episodeId;
  String openingCrawl;
  String director;
  String producer;
  String releaseDate;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        title: json["title"],
        episodeId: json["episode_id"],
        openingCrawl: json["opening_crawl"],
        director: json["director"],
        producer: json["producer"],
        releaseDate: json["release_date"],
      );

  static List<Movie> fromList(List jsonlist) {
    List<Movie> moviesList = [];
    for (var item in jsonlist) {
      moviesList.add(Movie.fromJson(item));
    }
    return moviesList;
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "episode_id": episodeId,
        "opening_crawl": openingCrawl,
        "director": director,
        "producer": producer,
        "release_date": releaseDate,
      };
}
