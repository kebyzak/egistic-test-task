import 'package:flutter/material.dart';
import 'package:imdb_bloc/models/actor.dart';

class ActorDetail extends StatelessWidget {
  final Actor actorDetail;

  const ActorDetail({Key? key, required this.actorDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Description'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ActorDetailCard(title: "Name: ${actorDetail.name}"),
            ActorDetailCard(title: "Height: ${actorDetail.height}"),
            ActorDetailCard(title: "Mass: ${actorDetail.mass}"),
            ActorDetailCard(title: "Hair Color: ${actorDetail.hairColor}"),
            ActorDetailCard(title: "Skin Color: ${actorDetail.skinColor}"),
            ActorDetailCard(title: "Eye Color: ${actorDetail.eyeColor}"),
            ActorDetailCard(title: "Birth Year: ${actorDetail.birthYear}"),
            ActorDetailCard(title: "Gender: ${actorDetail.gender}"),
          ],
        ),
      ),
    );
  }
}

class ActorDetailCard extends StatelessWidget {
  final String title;
  const ActorDetailCard({Key? key, required this.title}) : super(key: key);

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
