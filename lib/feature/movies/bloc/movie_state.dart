// ignore_for_file: must_be_immutable

part of 'movie_bloc.dart';

@immutable
abstract class MovieState {}

class MovieInitial extends MovieState {}

class LoadingState extends MovieState {}

class MovieLoadedState extends MovieState {
  List<Movie> movies;
  MovieLoadedState({required this.movies});
}

class FailedToLoadState extends MovieState {
  String error;
  FailedToLoadState({required this.error});
}
