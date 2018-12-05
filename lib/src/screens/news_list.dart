import 'package:flutter/material.dart';
import 'dart:async';
import '../blocs/stories.provider.dart';
import '../blocs/stories_bloc.dart';

class NewsList extends StatelessWidget {

  @override
    Widget build(BuildContext context) {
      final StoriesBloc bloc = StoriesProvider.of(context);
      bloc.fetchTopIds();
      return Scaffold(
        appBar: AppBar(
          title: Text('Top News!'),
        ),
        body: buildList(bloc),
      );
    }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return Text('Item number $index');
            },
          );
        }
      },
    );
  }

}