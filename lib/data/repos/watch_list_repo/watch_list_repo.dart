import 'package:movies_app/data/model/watch_list_data_model/watch_list_dm.dart';
import 'package:movies_app/data/repos/watch_list_repo/watch_list_ds.dart';

class WatchListRepo {
  WatchListDataSource watchListDataSource;

  WatchListRepo(this.watchListDataSource);

  Future<List<WatchListDM>> getWatchedList() async {
    List<WatchListDM> watchedList = await watchListDataSource.getWatchedList();
    return watchedList;
  }

  void deleteMovie(String id) {
    watchListDataSource.deleteMovie(id);
  }
}
