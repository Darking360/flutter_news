import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';
import 'dart:async';

class StoriesBloc {
  final _topIdsController = PublishSubject<List<int>>();
  final _itemsController = BehaviorSubject<int>();
  final _repository = Repository();
  Observable<Map<int, Future<ItemModel>>> _items;

  StoriesBloc() {
    _items = _itemsController.transform(_itemsTransformer());
  }

  // Getters to Streams
  Observable<List<int>> get topIds => _topIdsController.stream;
  
  //Getters to Sinks
  Function(int) get fetchItem => _itemsController.sink.add;

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIdsController.sink.add(ids);
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>>cache, int id, _) {
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  dispose() {
    _topIdsController.close();
    _itemsController.close();
  }
}