import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statemanagementbtest/homepage/bloc/home_bloc.dart';
import 'package:statemanagementbtest/homepage/model/home_model.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('bloc')),
      body: Column(
        children: [
          BlocConsumer<HomeBloc, HomeState>(
            bloc: homeBloc,
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is HomeInitialState) {
                homeBloc.add(DataFetchedEvent());
                return Container();
              }

              if (state is HomeLoadingState) {
                return const CircularProgressIndicator();
              } else if (state is HomeSucessState) {
                Homemodel model = state.homemodel;

                List textwidget = [];

                for (var i = 0; i < model.data.length; i++) {
                  var item = model.data[i];
                  var listtile = ListTile(
                    leading: Image.network(item.avatar),
                    title: Text('${item.firstName} ${item.lastName}'),
                    subtitle: Text(item.email),
                    trailing: Text(item.id.toString()),
                  );

                  textwidget.add(listtile);
                }
                return Column(
                  children: [
                    ListView.builder(
                        itemCount: model.data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return textwidget[index];
                        })
                  ],
                );
              } else if (state is HomeErrorState) {
                return Text(state.message);
              }
              return const Text('something is wrong');
            },
          )
        ],
      ),
    );
  }
}
