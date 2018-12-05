import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocs/stories_bloc.dart' show StoriesBloc;
import '../blocs/stories.provider.dart';

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
            return Text('Stream still loading');
          } else {
            return FutureBuilder(
              future: snapshot.data[id],
              builder: (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
                if (!itemSnapshot.hasData) {
                  return Text('Still loading item $id');
                } else {
                  return buildTile(itemSnapshot.data);
                }
              },
            );
          }
        },
      );
    }

  Widget buildTile(ItemModel item) {
    return Column(
      children: <Widget>[
        ListTile(
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