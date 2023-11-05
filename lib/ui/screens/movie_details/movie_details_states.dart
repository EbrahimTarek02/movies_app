import 'package:movies_app/data/model/movie_details_response/movie_details_response.dart';
import 'package:movies_app/data/model/movies_response/movies_response.dart';

abstract class MovieDetailsStates {}

class MovieDetailsInitialState extends MovieDetailsStates {}

class MovieDetailsLoadingState extends MovieDetailsStates {}

class MovieDetailsSuccessState extends MovieDetailsStates {
  MovieDetailsResponse movieDetailsResponse;

  MovieDetailsSuccessState(this.movieDetailsResponse);
}

class MovieDetailsListSuccessState extends MovieDetailsStates {
  MoviesResponse moviesResponse;

  MovieDetailsListSuccessState(this.moviesResponse);
}

class MovieDetailsErrorState extends MovieDetailsStates {}
