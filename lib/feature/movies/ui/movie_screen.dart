import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_bloc/const.dart';
import 'package:imdb_bloc/feature/movies/bloc/movie_bloc.dart';
import 'package:imdb_bloc/feature/movies/ui/movie_detail_g.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key}) : super(key: key);
  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class Debouncer {
  late final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer?.cancel();
    }

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class _MovieScreenState extends State<MovieScreen> {
  final MovieBloc _movieBloc = MovieBloc();
  List movies = [];
  final TextEditingController _editingController = TextEditingController();
  String currentSearch = '';
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _movieBloc.add(MovieLoadEvent());
    _movieBloc.add(MovieSearchEvent(currentSearch: ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: TextField(
            controller: _editingController,
            onChanged: (value) {
              _debouncer.run(() {
                currentSearch = _editingController.text;
                movies = [];
                _movieBloc.add(MovieSearchEvent(
                  currentSearch: _editingController.text,
                ));
              });
            },
            decoration: kInputDecoration,
          ),
        ),
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
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(movies[index].episodeId.toString()),
                    ),
                    title: Text(
                      movies[index].title,
                      // ignore: prefer_const_constructors
                      style: (TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MovieDetailG(
                            //index: index,
                            movieDetail: movies[index],
                          ),
                        ),
                      );
                    },
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
