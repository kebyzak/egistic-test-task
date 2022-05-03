import 'package:imdb_bloc/models/actor.dart';
import 'dart:convert';

APaginator actorFromJson(String str) => APaginator.fromJson(json.decode(str));

class APaginator {
  APaginator({
    required this.count,
    required this.next,
    required this.previous,
    required this.actors,
  });

  int count;
  String next;
  String? previous;
  List<Actor> actors;

  factory APaginator.fromJson(Map<String, dynamic> json) => APaginator(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        actors: Actor.fromList(json["results"]),
      );
}
