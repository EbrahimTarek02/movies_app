import 'package:movies_app/data/model/movies_response/movies_response.dart';

abstract class CategoryStates {}

class CategoriesSuccessState extends CategoryStates {
  List<Result> list;

  CategoriesSuccessState(this.list);
}

class CategoriesErrorState extends CategoryStates {
  String errorText;

  CategoriesErrorState(this.errorText);
}

class CategoriesLoadingState extends CategoryStates {}
