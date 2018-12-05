import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';
import 'dart:async';

class StoriesBloc {
  final _topIdsController = PublishSubject<List<int>>();
  final _itemsController = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _itemsFetchcer = PublishSubject<int>();
  final _repository = Repository();


  StoriesBloc() {
    _itemsFetchcer.stream.transform(_itemsTransformer()).pipe(_itemsController);
  }

  // Getters to Streams
  Observable<List<int>> get topIds => _topIdsController.stream;
  Observable<Map<int, Future<ItemModel>>> get items => _itemsController.stream;
  
  //Getters to Sinks
  Function(int) get fetchItem => _itemsFetchcer.sink.add;

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIdsController.sink.add(ids);
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>>cache, int id, index) {
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  dispose() {
    _topIdsController.close();
    _itemsController.close();
    _itemsFetchcer.close();
  }
}