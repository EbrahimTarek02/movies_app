import 'package:movies_app/data/model/watch_list_data_model/watch_list_dm.dart';

class MovieDetailsArgs {
  String movieId;
  List<WatchListDM> watchedMoviesList;

  MovieDetailsArgs(this.movieId, this.watchedMoviesList);
}
