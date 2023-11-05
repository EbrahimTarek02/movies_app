import 'dart:convert';
import 'package:movies_app/data/model/browse_response/browse_response.dart';
import 'package:http/http.dart' as http;

class BrowseDataSource {
  static const String baseUrl = "api.themoviedb.org";
  static const String apiKey = "cb223dfe2295c5cc9acf379eca60015b";

  Future<BrowseResponse> getGenres() async {
    Uri url = Uri.https(baseUrl, "3/genre/movie/list", {"api_key": apiKey});
    http.Response response = await http.get(url);
    Map json = jsonDecode(response.body);
    BrowseResponse categoriesResponse = BrowseResponse.fromJson(json);
    if (response.statusCode >= 200 &&
        response.statusCode < 300 &&
        categoriesResponse.genres?.isNotEmpty == true) {
      return categoriesResponse;
    } else {
      throw Exception("something went wrong");
    }
  }
}
