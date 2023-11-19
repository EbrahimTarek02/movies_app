import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/model/movies_response/movies_response.dart';
import 'package:movies_app/data/model/watch_list_data_model/watch_list_dm.dart';
import 'package:movies_app/data/repos/category_screen_repo/categories_screen_repo.dart';
import 'package:movies_app/data/repos/home_tab_repo/home_tab_repo.dart';
import 'package:movies_app/ui/screens/category/category_screen_states.dart';

class CategoryScreenViewModel extends Cubit {
  CategoryRepo categoriesRepo;
  HomeTabRepo repo = HomeTabRepo();

  CategoryScreenViewModel(this.categoriesRepo) : super(CategoryStates);

  void getResults(int id) async {
    emit(CategoriesLoadingState());
    try {
      MoviesResponse moviesResponse = await categoriesRepo.getResults(id);
      if (moviesResponse.results?.isNotEmpty == true) {
        List<WatchListDM> watchedMoviesList = await repo.getWatchedList();
        emit(
            CategoriesSuccessState(moviesResponse.results!, watchedMoviesList));
      }
    } catch (e) {
      emit(CategoriesErrorState(e.toString()));
    }
  }
}
