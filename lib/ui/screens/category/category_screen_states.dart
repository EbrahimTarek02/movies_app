import 'package:movies_app/data/model/movies_response/movies_response.dart';
import 'package:movies_app/data/model/watch_list_data_model/watch_list_dm.dart';

abstract class CategoryStates {}

class CategoriesSuccessState extends CategoryStates {
  List<Result> list;
  List<WatchListDM> watchedMoviesList;

  CategoriesSuccessState(this.list, this.watchedMoviesList);
}

class CategoriesErrorState extends CategoryStates {
  String errorText;

  CategoriesErrorState(this.errorText);
}

class CategoriesLoadingState extends CategoryStates {}
