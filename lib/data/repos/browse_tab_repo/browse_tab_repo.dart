import 'package:movies_app/data/model/browse_response/browse_response.dart';
import 'package:movies_app/data/repos/browse_tab_repo/browse_tab_ds.dart';

class BrowseTabRepo {
  BrowseDataSource browseDataSource;

  BrowseTabRepo(this.browseDataSource);

  Future<BrowseResponse> getGenres() async {
    BrowseResponse categoriesResponse = await browseDataSource.getGenres();
    return categoriesResponse;
  }
}
