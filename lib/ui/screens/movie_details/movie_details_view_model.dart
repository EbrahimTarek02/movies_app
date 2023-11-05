import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/model/movie_details_response/movie_details_response.dart';
import 'package:movies_app/data/model/movies_response/movies_response.dart';
import 'package:movies_app/data/repos/movie_details_repo/movie_details_repo.dart';
import 'package:movies_app/ui/screens/movie_details/movie_details_states.dart';

class MovieDetailsViewModel extends Cubit<MovieDetailsStates> {
  MovieDetailsViewModel() : super(MovieDetailsInitialState());
  MovieDetailsRepo repo = MovieDetailsRepo();

  void getMovieDetails(String movieId) async {
    emit(MovieDetailsLoadingState());
    MovieDetailsResponse movieDetailsResponse =
        await repo.getMovieDetails(movieId);

    if (movieDetailsResponse.genres?.isNotEmpty == true) {
      emit(MovieDetailsSuccessState(movieDetailsResponse));
    } else {
      emit(MovieDetailsErrorState());
    }
  }

  void getSimilarMovies(String movieId) async {
    emit(MovieDetailsLoadingState());
    MoviesResponse moviesResponse = await repo.getSimilarMovies(movieId);

    if (moviesResponse.results?.isNotEmpty == true) {
      emit(MovieDetailsListSuccessState(moviesResponse));
    } else {
      emit(MovieDetailsErrorState());
    }
  }
}
