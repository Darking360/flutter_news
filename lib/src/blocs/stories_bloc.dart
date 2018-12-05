import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _topIdsController = PublishSubject<List<int>>();
  final repository = Repository();

  // Getter to get Streams
  Observable<List<int>> get topIds => _topIdsController.stream;

  fetchTopIds() async {
    final ids = await repository.fetchTopIds();
    _topIdsController.sink.add(ids);
  }

  dispose() {
    _topIdsController.close();
  }
}