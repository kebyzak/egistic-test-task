import 'package:bloc/bloc.dart';
import 'package:imdb_bloc/models/movie.dart';
import 'package:imdb_bloc/repositories/movie_repository.dart';
import 'package:meta/meta.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final _movieRepository = MovieRepository();

  MovieBloc() : super(LoadingState()) {
    on<MovieLoadEvent>(_movieRepository.getMovies);
  }
}
