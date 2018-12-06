import 'package:flutter/material.dart';
import '../blocs/comments_provider.dart';
import '../blocs/comments_bloc.dart';
import '../models/item_model.dart';
import '../widgets/comment.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;

  NewsDetail({ this.itemId });

  @override
    Widget build(BuildContext context) {
      final CommentsBloc bloc = CommentsProvider.of(context);
      return Scaffold(
        appBar: AppBar(
          title: Text('Detail'),
        ),
        body: buildBody(bloc),
      );
    }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (BuildContext context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final itemFuture = snapshot.data[itemId];
          return FutureBuilder(
            future: itemFuture,
            builder: (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
              if (!itemSnapshot.hasData) {
                return Text('Loading...');
              } else {
                return buildList(itemSnapshot.data, snapshot.data);
              }
            },
          );
        }
      },
    );
  }

  Widget buildTitle(ItemModel item) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(10.0),
      child: Text(
        item.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    final commentsList = item.kids.map((kidId) {
      return Comment(
        itemId: kidId,
        itemMap: itemMap,
        depth: 0,
      );
    }).toList();

    final children = <Widget>[];
    children.add(buildTitle(item));
    children.addAll(commentsList);

    return ListView(
      children: children,
    );
  }

}