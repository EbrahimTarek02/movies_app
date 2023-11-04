import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:movies_app/data/model/search/results_response.dart';
import 'package:movies_app/data/repos/serach%20repo/search_ds.dart';

class SearchRepo {
  SearchDataSource searchDataSource;

  SearchRepo(this.searchDataSource);

  Future<ResultsResponse> getResults(String query) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      ResultsResponse response = await searchDataSource.getResults(query);
      return response;
    } else
    {
      throw Exception("No connection");
    }
  }
}
