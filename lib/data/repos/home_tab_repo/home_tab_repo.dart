import 'package:movies_app/data/model/movies_response/movies_response.dart';
import 'package:movies_app/data/model/watch_list_data_model/watch_list_dm.dart';
import 'package:movies_app/data/repos/home_tab_repo/home_tab_data_sources/home_tab_online_ds.dart';

class HomeTabRepo {
  HomeTabOnlineDS homeTabOnlineDS = HomeTabOnlineDS();

  Future<MoviesResponse> getPopularMovies() async {
    MoviesResponse popularResponse = await homeTabOnlineDS.getPopularMovies();
    return popularResponse;
  }

  Future<MoviesResponse> getUpcomingMovies() async {
    MoviesResponse upcomingResponse = await homeTabOnlineDS.getUpcomingMovies();
    return upcomingResponse;
  }

  Future<MoviesResponse> getTopRatedMovies() async {
    MoviesResponse topRatedResponse = await homeTabOnlineDS.getTopRatedMovies();
    return topRatedResponse;
  }

  Future<List<WatchListDM>> getWatchedList() async {
    List<WatchListDM> watchedList = await homeTabOnlineDS.getWatchedList();
    return watchedList;
  }
}
