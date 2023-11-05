import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/data/model/movies_response/movies_response.dart';

class CategoryDataSource {
  static const String baseUrl = "api.themoviedb.org";
  static const String apiKey = "cb223dfe2295c5cc9acf379eca60015b";

  Future<MoviesResponse> getResults(int id) async {
    var url = Uri.parse(
        "https://api.themoviedb.org/3/discover/movie?api_key=cb223dfe2295c5cc9acf379eca60015b&with_genres=$id");
    http.Response response = await http.get(url);
    Map json = jsonDecode(response.body);
    MoviesResponse moviesResponse = MoviesResponse.fromJson(json);
    if (response.statusCode >= 200 &&
        response.statusCode < 300 &&
        moviesResponse.results?.isNotEmpty == true) {
      return moviesResponse;
    } else {
      throw Exception("something went wrong");
    }
  }
}
