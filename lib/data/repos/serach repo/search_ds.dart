import 'dart:convert';
import 'package:movies_app/data/model/search/results_response.dart';
import 'package:http/http.dart' as http;

class SearchDataSource {

  static const String baseUrl = "api.themoviedb.org";
  static const String apiKey = "cb223dfe2295c5cc9acf379eca60015b";

  Future<ResultsResponse> getResults(String query) async {
    Uri url = Uri.https(baseUrl , "3/search/movie" ,
      {
        "api_key" : apiKey ,
        "query" : query ,
      }
    );
    http.Response response = await http.get(url);
    Map json = jsonDecode(response.body);
    ResultsResponse resultsResponse = ResultsResponse.fromJson(json);
    if(response.statusCode >= 200 &&
        response.statusCode < 300 &&
        resultsResponse.results?.isNotEmpty == true) {
      return resultsResponse ;
    }else
    {
      throw Exception("something went wrong");
    }
  }
}