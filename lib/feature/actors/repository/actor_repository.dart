import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:imdb_bloc/feature/actors/bloc/actor_bloc.dart';
import 'package:imdb_bloc/models/paginator.dart';

class ActorRepository {
  Future<void> getActors(
      ActorSearchEvent event, Emitter<ActorState> emit) async {
    emit(LoadingState());
    final searchResponse = await get(Uri.parse(
        "https://swapi.dev/api/people/?search=${event.currentSearch}&page=${event.currentPage}"));
    if (searchResponse.statusCode == 200) {
      Paginator spaginators =
          Paginator.fromJson(jsonDecode(searchResponse.body));
      emit(ActorLoadedState(paginators: spaginators));
    } else {
      throw Exception('failed');
    }
  }
}
