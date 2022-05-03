/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_bloc/bloc/actor_bloc.dart';
import 'package:imdb_bloc/presentation/actors_screen.dart';
import 'package:imdb_bloc/presentation/home_screen.dart';
import 'package:imdb_bloc/presentation/movie_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(
            title: 'home screen',
            color: Colors.blueAccent,
          ),
        );
      case '/actor':
        return MaterialPageRoute(builder: (_) => const ActorScreen());
      case '/movie':
        return MaterialPageRoute(builder: (_) => const MovieScreen());
      default:
        return null;
    }
  }
}
*/