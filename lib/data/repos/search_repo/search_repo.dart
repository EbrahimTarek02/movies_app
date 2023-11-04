import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:movies_app/data/model/movies_response/movies_response.dart';
import 'package:movies_app/data/repos/search_repo/search_ds.dart';

class SearchRepo {
  SearchDataSource searchDataSource;

  SearchRepo(this.searchDataSource);

  Future<MoviesResponse> getResults(String query) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      MoviesResponse response = await searchDataSource.getResults(query);
      return response;
    } else {
      throw Exception("No connection");
    }
  }
}