import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_bloc/feature/movies/bloc/movie_bloc.dart';
import 'package:imdb_bloc/models/movie.dart';

// ignore: must_be_immutable
class MovieDetail extends StatefulWidget {
  int index;
  MovieDetail({Key? key, required this.index}) : super(key: key);

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  final MovieBloc _movieBloc = MovieBloc();
  late Movie movieById;
  int currentId = 0;

  @override
  void initState() {
    super.initState();
    _movieBloc.add(MovieByIdEvent(currentId: widget.index + 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Description'),
        backgroundColor: Colors.redAccent,
      ),
      body: BlocProvider(
        create: (BuildContext context) => _movieBloc,
        child: BlocConsumer<MovieBloc, MovieState>(
          listener: (context, state) {
            if (state is MovieIdLoadedState) {
              movieById = state.movieById;
            }
          },
          builder: (context, state) {
            if (state is FailedToLoadState) {
              return Center(child: Text(state.error));
            }

            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    MovieDetailCard(title: "Episode: ${movieById.title}"),
                    MovieDetailCard(
                        title: "Episode: ${movieById.episodeId.toString()}"),
                    MovieDetailCard(title: "Director: ${movieById.director}"),
                    MovieDetailCard(
                        title: "Producer(s): ${movieById.producer}"),
                    MovieDetailCard(
                        title: "Release Date: ${movieById.releaseDate}"),
                    MovieDetailCard(title: movieById.openingCrawl),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class MovieDetailCard extends StatelessWidget {
  final String title;
  const MovieDetailCard({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
      elevation: 8,
      shadowColor: Colors.redAccent,
      margin: const EdgeInsets.all(10),
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white)),
    );
  }
}
