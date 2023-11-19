import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/model/movies_response/movies_response.dart';
import 'package:movies_app/data/model/watch_list_data_model/watch_list_dm.dart';
import 'package:movies_app/data/repos/movie_poster_repo/movie_poster_repo.dart';
import 'package:movies_app/data/repos/watch_list_repo/watch_list_ds.dart';
import 'package:movies_app/data/repos/watch_list_repo/watch_list_repo.dart';
import 'package:movies_app/ui/common/movie_poster_states.dart';

class MoviePosterViewModel extends Cubit<MoviePosterStates> {
  MoviePosterViewModel() : super(MoviePosterInitialState());

  // bool pressed = false;

  MoviePosterRepo repo = MoviePosterRepo();
  WatchListRepo listRepo = WatchListRepo(WatchListDataSource());

  String addToFirestore(Result movie) {
    return repo.addToFirestore(movie);
  }

  void deleteMovie(String id) {
    repo.deleteMovie(id);
  }

  bool isWatched(List<WatchListDM> watchedMoviesList, Result movie) {
    for (int i = 0; i < watchedMoviesList.length; i++) {
      if (watchedMoviesList[i].result!.title == movie.title) {
        emit(Watched());
        return true;
      }
    }
    emit(NotWatched());
    return false;
  }

  void onTap(List<WatchListDM> watchedMoviesList, Result movie) async {
    if (isWatched(watchedMoviesList, movie)) {
      for (int i = 0; i < watchedMoviesList.length; i++) {
        if (watchedMoviesList[i].result!.title == movie.title) {
          deleteMovie(watchedMoviesList[i].id.toString());
          watchedMoviesList.removeAt(i);
          emit(NotWatched());
        }
      }
    } else {
      String id = addToFirestore(movie);
      watchedMoviesList
          .add(WatchListDM(result: movie, isWatched: true, id: id));
      emit(Watched());
    }
  }
}
