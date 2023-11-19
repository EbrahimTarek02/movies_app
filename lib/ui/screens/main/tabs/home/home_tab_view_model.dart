import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/model/movies_response/movies_response.dart';
import 'package:movies_app/data/model/watch_list_data_model/watch_list_dm.dart';
import 'package:movies_app/data/repos/home_tab_repo/home_tab_repo.dart';
import 'package:movies_app/ui/screens/main/tabs/home/home_tab_states.dart';

class HomeTabViewModel extends Cubit<HomeTabStates> {
  HomeTabViewModel() : super(HomeTabInitialState());
  HomeTabRepo repo = HomeTabRepo();

  void getPopularMovies() async {
    emit(HomeTabLoadingState());
    MoviesResponse popularResponse = await repo.getPopularMovies();

    if (popularResponse.results != null &&
        popularResponse.results?.isNotEmpty == true) {
      List<WatchListDM> list = await repo.getWatchedList();
      emit(HomeTabSuccessState(popularResponse, list));
    } else {
      emit(HomeTabErrorState());
    }
  }

  void getUpcomingMovies() async {
    emit(HomeTabLoadingState());
    MoviesResponse upcomingResponse = await repo.getUpcomingMovies();

    if (upcomingResponse.results?.isNotEmpty == true) {
      List<WatchListDM> list = await repo.getWatchedList();
      emit(HomeTabSuccessState(upcomingResponse, list));
    } else {
      emit(HomeTabErrorState());
    }
  }

  void getTopRatedMovies() async {
    emit(HomeTabLoadingState());
    MoviesResponse topRatedResponse = await repo.getTopRatedMovies();

    if (topRatedResponse.results?.isNotEmpty == true) {
      List<WatchListDM> list = await repo.getWatchedList();
      emit(HomeTabSuccessState(topRatedResponse, list));
    } else {
      emit(HomeTabErrorState());
    }
  }
}
