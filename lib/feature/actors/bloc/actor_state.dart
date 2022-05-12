// ignore_for_file: must_be_immutable

part of 'actor_bloc.dart';

@immutable
abstract class ActorState {}

class ActorInitial extends ActorState {}

class LoadingState extends ActorState {
  LoadingState();
}

class ActorLoadedState extends ActorState {
  Paginator paginators;
  ActorLoadedState({required this.paginators});
}

class FailedToLoadState extends ActorState {
  final String error;
  FailedToLoadState({required this.error});
}
