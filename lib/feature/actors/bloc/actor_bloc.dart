import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_bloc/models/paginator.dart';
import 'package:imdb_bloc/feature/actors/repository/actor_repository.dart';

part 'actor_event.dart';
part 'actor_state.dart';

class ActorBloc extends Bloc<ActorEvent, ActorState> {
  final _actorRepository = ActorRepository();

  ActorBloc() : super(ActorInitial()) {
    on<ActorSearchEvent>(_actorRepository.getActors);
  }
}
