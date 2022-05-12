part of 'movie_bloc.dart';

@immutable
abstract class MovieEvent {}

class MovieLoadEvent extends MovieEvent {}

// ignore: must_be_immutable
class MovieSearchEvent extends MovieEvent {
  String currentSearch;
  MovieSearchEvent({required this.currentSearch});
}

// ignore: must_be_immutable
class MovieExtractEvent extends MovieEvent {
  String currentMovie;
  MovieExtractEvent({required this.currentMovie});
}
