import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_bloc/bloc/actor_bloc.dart';
import '../models/actor.dart';

class ActorScreen extends StatefulWidget {
  const ActorScreen({Key? key}) : super(key: key);
  @override
  State<ActorScreen> createState() => _ActorScreenState();
}

class _ActorScreenState extends State<ActorScreen> {
  List<Actor> actors = [];
  final ScrollController controller = ScrollController();
  final ActorBloc _movieBloc = ActorBloc();

  @override
  void initState() {
    super.initState();
    _movieBloc.add(ActorLoadEvent());
    controller.addListener(() {
      if (controller.position.pixels >= controller.position.maxScrollExtent) {
        context.read<ActorBloc>().add(ActorLoadEvent());
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
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ActorBloc>().add(ActorLoadEvent());
        },
        child: BlocBuilder<ActorBloc, ActorState>(
          builder: (context, state) {
            if (state is ActorLoadedState) {
              actors.addAll(state.apaginators.actors);
              ListView.builder(
                controller: controller,
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
              );
            } else if (state is FailedToLoadState) {
              return Center(child: Text(state.error));
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
            print(actors);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
