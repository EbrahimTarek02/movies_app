import 'package:movies_app/data/model/movies_response/movies_response.dart';

abstract class HomeTabStates {}

class HomeTabInitialState extends HomeTabStates {}

class HomeTabLoadingState extends HomeTabStates {}

class HomeTabSuccessState extends HomeTabStates {
  MoviesResponse moviesResponse;

  HomeTabSuccessState(this.moviesResponse);
}

class HomeTabErrorState extends HomeTabStates {}