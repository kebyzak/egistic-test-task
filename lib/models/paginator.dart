import 'package:imdb_bloc/models/actor.dart';
import 'dart:convert';

Paginator actorFromJson(String str) => Paginator.fromJson(json.decode(str));

class Paginator {
  Paginator({
    required this.count,
    required this.next,
    required this.previous,
    required this.actors,
  });

  int count;
  String? next;
  String? previous;
  List<Actor> actors;

  factory Paginator.fromJson(Map<String, dynamic> json) => Paginator(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        actors: Actor.fromList(json["results"]),
      );
}
