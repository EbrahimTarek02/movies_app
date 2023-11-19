import 'package:movies_app/data/model/movies_response/movies_response.dart';
import 'package:movies_app/data/repos/movie_poster_repo/movie_poster_data_sources/movie_poster_offline_ds.dart';

class MoviePosterRepo {
  MoviePosterOfflineDS moviePosterOfflineDS = MoviePosterOfflineDS();

  String addToFirestore(Result movie) {
    return moviePosterOfflineDS.addToFirestore(movie);
    // print('added in repo');
  }

  void deleteMovie(String id) {
    moviePosterOfflineDS.deleteMovie(id);
  }
}
