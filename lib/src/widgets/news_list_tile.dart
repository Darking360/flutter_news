import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocs/stories_bloc.dart' show StoriesBloc;
import '../blocs/stories.provider.dart';
import 'loading_container.dart';

class NewsListTile extends StatelessWidget {
  final int id;

  NewsListTile(this.id);

  @override
    Widget build(BuildContext context) {
      final StoriesBloc bloc = StoriesProvider.of(context);
      return StreamBuilder(
        stream: bloc.items,
        builder: (BuildContext context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
          if (!snapshot.hasData) {
            return LoadingContainer();
          } else {
            return FutureBuilder(
              future: snapshot.data[id],
              builder: (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
                if (!itemSnapshot.hasData) {
                  return LoadingContainer();
                } else {
                  return buildTile(context, itemSnapshot.data);
                }
              },
            );
          }
        },
      );
    }

  Widget buildTile(BuildContext context, ItemModel item) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, '/${item.id}');
          },
          title: Text(item.title),
          subtitle: Text('${item.score} votes'),
          trailing: Column(
            children: <Widget>[
              Icon(Icons.comment),
              Text('${item.descendants}'),
            ],
          ),
        ),
        Divider(height: 2.0, color: Colors.grey)
      ],
    );
  }
}