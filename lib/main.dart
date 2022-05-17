import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_bloc/feature/actors/bloc/actor_bloc.dart';
import 'package:imdb_bloc/feature/actors/ui/actors_screen.dart';
import 'package:imdb_bloc/feature/movies/bloc/movie_bloc.dart';
import 'package:imdb_bloc/feature/movies/ui/movie_screen.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatefulWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  int currentIndex = 0;

  final screens = [
    const MovieScreen(),
    const ActorScreen(),
  ];

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
      child: MaterialApp(
        home: Scaffold(
          body: IndexedStack(
            children: screens,
            index: currentIndex,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            onTap: (index) => setState(() => currentIndex = index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.movie),
                label: 'movies',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'actors',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
