import 'package:movies_app/data/model/movies_response/movies_response.dart';
import 'package:movies_app/data/repos/category_screen_repo/categories_screen_data_source.dart';

class CategoryRepo {
  CategoryDataSource categoriesDataSource;

  CategoryRepo(this.categoriesDataSource);

  Future<MoviesResponse> getResults(int id) async {
    MoviesResponse moviesResponse = await categoriesDataSource.getResults(id);
    return moviesResponse;
  }
}
