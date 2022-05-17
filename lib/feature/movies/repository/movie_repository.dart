import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:imdb_bloc/feature/movies/bloc/movie_bloc.dart';
import 'package:imdb_bloc/models/movie.dart';

class MovieRepository {
  Future<void> getMovies(MovieLoadEvent event, Emitter<MovieState> emit) async {
    emit(LoadingState());
    final response = await get(Uri.parse("https://swapi.dev/api/films/"));
    if (response.statusCode == 200) {
      List<Movie> movies = Movie.fromList(jsonDecode(response.body)['results']);
      emit(MovieLoadedState(movies: movies));
    } else {
      throw Exception('failed');
    }
  }

  Future<void> searchMovies(
      MovieSearchEvent event, Emitter<MovieState> emit) async {
    emit(LoadingState());
    final searchResponse = await get(Uri.parse(
        "https://swapi.dev/api/films/?search=${event.currentSearch}"));

    if (searchResponse.statusCode == 200) {
      List<Movie> movies =
          Movie.fromList(jsonDecode(searchResponse.body)['results']);
      emit(MovieLoadedState(movies: movies));
    } else {
      throw Exception('failed');
    }
  }

  Future<void> getMovieDetail(
      MovieByIdEvent event, Emitter<MovieState> emit) async {
    emit(LoadingState());
    final detailResponse =
        await get(Uri.parse("https://swapi.dev/api/films/${event.currentId}"));
    if (detailResponse.statusCode == 200) {
      Movie movieById = Movie.fromJson(jsonDecode(detailResponse.body));
      emit(MovieIdLoadedState(movieById: movieById));
    } else {
      throw Exception('failed');
    }
  }
}
