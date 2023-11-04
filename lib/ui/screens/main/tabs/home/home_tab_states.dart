import '../../../../../data/model/popular/popular_DM.dart';

abstract class HomeTabStates {}

class HomeTabInitialState extends HomeTabStates {}
class HomeTabLoadingState extends HomeTabStates {}
class HomeTabSuccessState extends HomeTabStates {
  MoviesResponse moviesResponse;
  HomeTabSuccessState(this.moviesResponse);
}
class HomeTabErrorState extends HomeTabStates {}