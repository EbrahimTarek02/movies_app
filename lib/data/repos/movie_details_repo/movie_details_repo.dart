import 'package:movies_app/data/model/movie_details_response/movie_details_response.dart';
import 'package:movies_app/data/model/movies_response/movies_response.dart';
import 'package:movies_app/data/repos/movie_details_repo/movie_details_data_sources/movie_details_online_ds.dart';

class MovieDetailsRepo {
  MovieDetailsOnlineDS movieDetailsOnlineDS = MovieDetailsOnlineDS();

  Future<MovieDetailsResponse> getMovieDetails(String movieId) async {
    MovieDetailsResponse movieDetailsResponse =
        await movieDetailsOnlineDS.getMovieDetails(movieId);
    return movieDetailsResponse;
  }

  Future<MoviesResponse> getSimilarMovies(String movieId) async {
    MoviesResponse moviesResponse =
        await movieDetailsOnlineDS.getSimilarMovies(movieId);
    return moviesResponse;
  }
}
