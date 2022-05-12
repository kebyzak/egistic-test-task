part of 'actor_bloc.dart';

@immutable
abstract class ActorEvent {}

// ignore: must_be_immutable
class ActorLoadEvent extends ActorEvent {
  int currentPage;

  ActorLoadEvent({
    required this.currentPage,
  });
}

// ignore: must_be_immutable
class ActorSearchEvent extends ActorEvent {
  int currentPage;
  String currentSearch;

  ActorSearchEvent({required this.currentSearch, required this.currentPage});
}
