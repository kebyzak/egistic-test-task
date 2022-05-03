import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:imdb_bloc/bloc/movie_bloc.dart';
import 'package:imdb_bloc/models/movie.dart';

class MovieRepository {
  Future<List<Movie>> getMovies(
      MovieLoadEvent event, Emitter<MovieState> emit) async {
    emit(LoadingState());

    final response = await get(Uri.parse("https://swapi.dev/api/films/"));
    if (response.statusCode == 200) {
      List<Movie> movies = Movie.fromList(jsonDecode(response.body)['results']);
      emit(MovieLoadedState(movies: movies));
      return movies;
    } else {
      throw Exception('failed');
    }
  }
}
