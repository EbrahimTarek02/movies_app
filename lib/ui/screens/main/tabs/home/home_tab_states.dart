import 'package:movies_app/data/model/movies_response/movies_response.dart';
import 'package:movies_app/data/model/watch_list_data_model/watch_list_dm.dart';

abstract class HomeTabStates {}

class HomeTabInitialState extends HomeTabStates {}

class HomeTabLoadingState extends HomeTabStates {}

class HomeTabSuccessState extends HomeTabStates {
  MoviesResponse moviesResponse;
  List<WatchListDM> watchedMoviesList;

  HomeTabSuccessState(this.moviesResponse, this.watchedMoviesList);
}

class HomeTabErrorState extends HomeTabStates {}
