import 'package:movies_app/data/model/watch_list_data_model/watch_list_dm.dart';
import 'package:movies_app/data/repos/home_screen_repo/home_screen_offline_ds.dart';

class HomeScreenRepo {
  HomeScreenOfflineDS homeScreenOfflineDS = HomeScreenOfflineDS();

  Future<List<WatchListDM>> getWatchedList() async {
    List<WatchListDM> watchedList = await homeScreenOfflineDS.getWatchedList();
    return watchedList;
  }
}
