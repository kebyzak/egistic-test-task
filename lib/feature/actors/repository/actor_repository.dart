import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:imdb_bloc/feature/actors/bloc/actor_bloc.dart';
import 'package:imdb_bloc/models/a_paginator.dart';

class ActorRepository {
  Future<void> getActors(ActorLoadEvent event, Emitter<ActorState> emit) async {
    emit(LoadingState());

    final response = await get(
        Uri.parse("https://swapi.dev/api/people/?page=${event.currentPage}"));
    if (response.statusCode == 200) {
      APaginator apaginators = APaginator.fromJson(jsonDecode(response.body));
      emit(ActorLoadedState(apaginators: apaginators));
    } else {
      throw Exception('failed');
    }
  }
}
