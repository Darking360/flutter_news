import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/item_model.dart';
import 'repository.dart' show Source;

final _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source {
  Client client = Client();

  Future<List<int>> fetchTopIds() async {
    final res = await client.get('$_root/topstories.json');
    final ids = json.decode(res.body);
    return ids.cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async {
    final res = await client.get('$_root/item/$id.json');
    return ItemModel.fromJSON(json.decode(res.body));
  }

}