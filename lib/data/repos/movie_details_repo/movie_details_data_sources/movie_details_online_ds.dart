import 'dart:convert';
import 'package:http/http.dart';
import 'package:movies_app/data/model/movie_details_response/movie_details_response.dart';
import 'package:movies_app/data/model/movies_response/movies_response.dart';

class MovieDetailsOnlineDS {
  static const String baseUrl = 'https://api.themoviedb.org';
  static const String apiKey = 'cb223dfe2295c5cc9acf379eca60015b';

  Future<MovieDetailsResponse> getMovieDetails(String movieId) async {
    try {
      const String endPoint = '/3/movie';
      String url = '$baseUrl$endPoint/$movieId?api_key=$apiKey';
      Response response = await get(Uri.parse(url));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        Map<String, dynamic> json = jsonDecode(response.body);
        MovieDetailsResponse movieDetailsResponse =
            MovieDetailsResponse.fromJson(json);
        return movieDetailsResponse;
      }
      throw Exception('Something went wrong please try again later');
    } catch (e) {
      rethrow;
    }
  }

  Future<MoviesResponse> getSimilarMovies(String movieId) async {
    try {
      const String endPoint = '/3/movie';
      String url = '$baseUrl$endPoint/$movieId/similar?api_key=$apiKey';
      Response response = await get(Uri.parse(url));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        Map<String, dynamic> json = jsonDecode(response.body);
        MoviesResponse moviesResponse = MoviesResponse.fromJson(json);
        return moviesResponse;
      }
      throw Exception('Something went wrong please try again later');
    } catch (e) {
      rethrow;
    }
  }
}
