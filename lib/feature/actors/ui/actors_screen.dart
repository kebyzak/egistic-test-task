import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_bloc/feature/actors/bloc/actor_bloc.dart';
import 'package:imdb_bloc/models/actor.dart';

class ActorScreen extends StatefulWidget {
  const ActorScreen({Key? key}) : super(key: key);
  @override
  State<ActorScreen> createState() => _ActorScreenState();
}

class _ActorScreenState extends State<ActorScreen> {
  final ActorBloc _actorBloc = ActorBloc();
  List<Actor> actors = [];
  final ScrollController _controller = ScrollController();
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    _actorBloc.add(ActorLoadEvent(currentPage: 1));
    _controller.addListener(() {
      if (_controller.position.pixels >= _controller.position.maxScrollExtent) {
        currentPage++;
        _actorBloc.add(ActorLoadEvent(currentPage: currentPage));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actors'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _controller,
              itemCount: actors.length,
              itemBuilder: (context, index) {
                Actor actorsDetails = actors[index];
                return Card(
                  child: ListTile(
                    trailing: Text(actorsDetails.hairColor),
                    title: Text(
                      actorsDetails.name,
                    ),
                    subtitle: Text(
                      actorsDetails.birthYear,
                    ),
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
                    actors.addAll(state.apaginators.actors);
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
    super.dispose();
    _controller.dispose();
  }
}
