import 'package:flutter/material.dart';
import 'package:imdb_bloc/models/movie.dart';

class MovieDetailG extends StatelessWidget {
  final Movie movieDetail;

  const MovieDetailG({Key? key, required this.movieDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Description'),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MovieDetailCard(title: "Title: ${movieDetail.title}"),
            MovieDetailCard(
                title: "Episode: ${movieDetail.episodeId.toString()}"),
            MovieDetailCard(title: "Director: ${movieDetail.director}"),
            MovieDetailCard(title: "Producer(s): ${movieDetail.producer}"),
            MovieDetailCard(title: "Release Date: ${movieDetail.releaseDate}"),
            MovieDetailCard(title: movieDetail.openingCrawl),
          ],
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
