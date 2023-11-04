import 'package:movies_app/data/model/search/results_response.dart';

abstract class SearchTabStates {}

class SearchTabInitialState extends SearchTabStates {}

class SearchTabSuccessState extends SearchTabStates {
  List<Result> result;

  SearchTabSuccessState(this.result);
}

class SearchTabErrorState extends SearchTabStates {
  String errorText;

  SearchTabErrorState(this.errorText);
}

class SearchTabLoadingState extends SearchTabStates {}
