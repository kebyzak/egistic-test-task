import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_bloc/bloc/actor_bloc.dart';
import 'package:imdb_bloc/bloc/movie_bloc.dart';
import 'package:imdb_bloc/presentation/home_screen.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieBloc>(
          create: (_) => MovieBloc(),
        ),
        BlocProvider<ActorBloc>(
          create: (_) => ActorBloc(),
        ),
      ],
      child: const MaterialApp(
        home: HomeScreen(
          color: Colors.purple,
          title: 'movie app',
        ),
      ),
    );
  }
}
