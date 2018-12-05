import 'dart:async';
import '../models/item_model.dart';
import 'news_api_provider.dart';
import 'news_db_provider.dart';

class Repository {
  NewsDbProvider _dbProvider = NewsDbProvider();
  NewsApiProvider _apiProvider = NewsApiProvider();

  Repository() {
    _dbProvider.init();
  }

  Future<List<int>> fetchTopIds() {
    return _apiProvider.fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    var item = await _dbProvider.fetchItem(id);
    if (item == null) {
      item = await _apiProvider.fetchItem(id);
      _dbProvider.addItem(item);
      return item;
    } else return item;
  }

}