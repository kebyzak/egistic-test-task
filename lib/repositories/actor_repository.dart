import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:imdb_bloc/bloc/actor_bloc.dart';
import 'package:imdb_bloc/models/a_paginator.dart';

class ActorRepository {
  Future<APaginator> getActors(
      ActorLoadEvent event, Emitter<ActorState> emit) async {
    emit(LoadingState());
    //emit(ActorLoadedState(apaginators: apaginators));
    final response =
        await get(Uri.parse("https://swapi.dev/api/people/?page=1"));
    if (response.statusCode == 200) {
      APaginator apaginators = APaginator.fromJson(jsonDecode(response.body));
      emit(ActorLoadedState(apaginators: apaginators));
      return apaginators;
    } else {
      throw Exception('failed');
    }
  }
}
