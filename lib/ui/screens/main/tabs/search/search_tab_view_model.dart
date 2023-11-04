import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/model/search/results_response.dart';
import 'package:movies_app/data/repos/serach%20repo/search_ds.dart';
import 'package:movies_app/data/repos/serach%20repo/search_repo.dart';
import 'package:movies_app/ui/screens/main/tabs/search/search_tab_states.dart';

class SearchTabViewModel extends Cubit{
  SearchTabViewModel() : super(SearchTabInitialState);

  SearchRepo searchRepo = SearchRepo(SearchDataSource());

  void getResults(String query) async{
    emit(SearchTabLoadingState());
    try
    {
      ResultsResponse resultsResponse = await searchRepo.getResults(query);
      if(resultsResponse.results?.isNotEmpty == true){
        emit(SearchTabSuccessState(resultsResponse.results!));
      }
    }
    catch(error)
    {
      emit(SearchTabErrorState(error.toString()));
    }
  }
}
