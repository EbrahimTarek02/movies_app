import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/model/popular/popular_DM.dart';
import 'package:movies_app/data/repos/home_tab_repo/home_tab_repo.dart';
import 'package:movies_app/ui/screens/main/tabs/home/home_tab_states.dart';

class HomeTabViewModel extends Cubit <HomeTabStates>{
  HomeTabViewModel() : super(HomeTabInitialState());
  HomeTabRepo repo = HomeTabRepo();

  void getPopularMovies() async{
    emit(HomeTabLoadingState());
    MoviesResponse popularResponse = await repo.getPopularMovies();

    if (popularResponse.results != null && popularResponse.results?.isNotEmpty == true) {
      emit(HomeTabSuccessState(
        popularResponse
      ));
    }
    else {
      emit(HomeTabErrorState());
    }
  }

  void getUpcomingMovies() async {
    emit(HomeTabLoadingState());
    MoviesResponse upcomingResponse = await repo.getUpcomingMovies();

    if (upcomingResponse != null && upcomingResponse.results?.isNotEmpty == true) {
      emit(HomeTabSuccessState(
        upcomingResponse
      ));
    }
    else{
      emit(HomeTabErrorState());
    }
  }

  void getTopRatedMovies() async {
    emit(HomeTabLoadingState());
    MoviesResponse topRatedResponse = await repo.getTopRatedMovies();

    if (topRatedResponse != null && topRatedResponse.results?.isNotEmpty == true) {
      emit(HomeTabSuccessState(
        topRatedResponse
      ));
    }
    else {
      emit(HomeTabErrorState());
    }
  }
}