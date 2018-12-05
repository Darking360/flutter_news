import 'package:flutter/material.dart';
import 'dart:async';
import '../blocs/stories.provider.dart';
import '../blocs/stories_bloc.dart';
import '../widgets/news_list_tile.dart';

class NewsList extends StatelessWidget {

  @override
    Widget build(BuildContext context) {
      final StoriesBloc bloc = StoriesProvider.of(context);
      bloc.fetchTopIds();
      return Scaffold(
        appBar: AppBar(
          title: Text('Top News!'),
        ),
        body: SafeArea(
          child: buildList(bloc),
        ),
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
              bloc.fetchItem(snapshot.data[index]);
              return NewsListTile(snapshot.data[index]);
            },
          );
        }
      },
    );
  }

}