import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_bloc/feature/movies/bloc/movie_bloc.dart';
import 'package:imdb_bloc/models/movie.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key}) : super(key: key);
  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final MovieBloc _movieBloc = MovieBloc();
  List movies = [];

  @override
  void initState() {
    super.initState();
    _movieBloc.add(MovieLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        backgroundColor: Colors.redAccent,
      ),
      body: BlocProvider(
        create: (BuildContext context) => _movieBloc,
        child: BlocConsumer<MovieBloc, MovieState>(
          listener: (context, state) {
            if (state is MovieLoadedState) {
              movies = state.movies;
            }
          },
          builder: (context, state) {
            if (state is FailedToLoadState) {
              return Center(child: Text(state.error));
            }

            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                Movie movie = movies[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(movie.episodeId.toString()),
                    ),
                    title: Text(
                      movie.title,
                    ),
                    subtitle: Text(
                      movie.director,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
