import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_bloc/const.dart';
import 'package:imdb_bloc/feature/actors/bloc/actor_bloc.dart';
import 'package:imdb_bloc/feature/actors/ui/actor_detail.dart';
import 'package:imdb_bloc/models/actor.dart';

class ActorScreen extends StatefulWidget {
  const ActorScreen({Key? key}) : super(key: key);
  @override
  State<ActorScreen> createState() => _ActorScreenState();
}

class Debouncer {
  late final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer?.cancel();
    }

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class _ActorScreenState extends State<ActorScreen> {
  final ActorBloc _actorBloc = ActorBloc();
  List<Actor> actors = [];
  final ScrollController _scrollingController = ScrollController();
  final TextEditingController _editingController = TextEditingController();
  int currentPage = 1;
  String currentSearch = '';
  final _debouncer = Debouncer(milliseconds: 1000);

  @override
  void initState() {
    super.initState();
    _actorBloc.add(ActorSearchEvent(currentSearch: '', currentPage: 1));
    _scrollingController.addListener(() {
      if (_scrollingController.offset >=
              _scrollingController.position.maxScrollExtent &&
          !_scrollingController.position.outOfRange) {
        currentPage++;
        _actorBloc.add(ActorSearchEvent(
          currentSearch: _editingController.text,
          currentPage: currentPage,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            controller: _editingController,
            onChanged: (value) {
              _debouncer.run(() {
                currentPage = 1;
                currentSearch = _editingController.text;
                actors = [];
                _actorBloc.add(ActorSearchEvent(
                  currentSearch: _editingController.text,
                  currentPage: currentPage,
                ));
                if (currentSearch.isEmpty) {
                  _actorBloc.add(ActorSearchEvent(
                    currentSearch: _editingController.text,
                    currentPage: 1,
                  ));
                }
              });
            },
            decoration: kInputDecoration,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollingController,
              itemCount: actors.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    trailing: Text(actors[index].hairColor),
                    title: Text(
                      actors[index].name,
                    ),
                    subtitle: Text(
                      actors[index].birthYear,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ActorDetail(
                            actorDetail: actors[index],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          BlocProvider(
            create: (BuildContext context) => _actorBloc,
            child: BlocConsumer<ActorBloc, ActorState>(
              listener: (context, state) {
                if (state is ActorLoadedState) {
                  setState(() {
                    actors.addAll(state.paginators.actors);
                  });
                }
              },
              builder: (context, state) {
                if (state is FailedToLoadState) {
                  return Center(child: Text(state.error));
                }
                if (state is LoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollingController.dispose();
    _editingController.dispose();
    super.dispose();
  }
}
