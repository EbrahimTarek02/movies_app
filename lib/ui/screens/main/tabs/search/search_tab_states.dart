import 'package:movies_app/data/model/movies_response/movies_response.dart';
import 'package:movies_app/data/model/watch_list_data_model/watch_list_dm.dart';

abstract class SearchTabStates {}

class SearchTabInitialState extends SearchTabStates {}

class SearchTabSuccessState extends SearchTabStates {
  List<Result> result;
  List<WatchListDM> watchedMoviesList;

  SearchTabSuccessState(this.result, this.watchedMoviesList);
}

class SearchTabErrorState extends SearchTabStates {
  String errorText;

  SearchTabErrorState(this.errorText);
}

class SearchTabLoadingState extends SearchTabStates {}
