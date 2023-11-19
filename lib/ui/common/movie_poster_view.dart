import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/model/movies_response/movies_response.dart';
import 'package:movies_app/data/model/watch_list_data_model/watch_list_dm.dart';
import 'package:movies_app/ui/common/movie_poster_states.dart';
import 'package:movies_app/ui/common/movie_poster_view_model.dart';
import 'package:movies_app/ui/util/app_assets.dart';

class MoviePosterView extends StatefulWidget {
  final Result movie;
  final bool inListView;
  final List<WatchListDM> watchedMoviesList;

  const MoviePosterView(this.watchedMoviesList, this.movie, this.inListView,
      {super.key});

  @override
  State<MoviePosterView> createState() => _MoviePosterViewState();
}

class _MoviePosterViewState extends State<MoviePosterView> {
  MoviePosterViewModel viewModel = MoviePosterViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.isWatched(widget.watchedMoviesList, widget.movie);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: viewModel,
      builder: (context, state) {
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: widget.inListView
                ? BorderRadius.circular(8.0)
                : BorderRadius.circular(12.0),
          ),
          child: Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              CachedNetworkImage(
                imageUrl:
                    "https://image.tmdb.org/t/p/w500${widget.movie.posterPath}",
                fit: BoxFit.fill,
                height: widget.inListView
                    ? MediaQuery.of(context).size.height * 0.2
                    : MediaQuery.of(context).size.height * 0.25,
                width: widget.inListView
                    ? MediaQuery.of(context).size.width * 0.25
                    : MediaQuery.of(context).size.width * 0.3,
                errorWidget: (_, __, ___) {
                  return Image.network(
                    'https://michaelnakache.com/wp-content/uploads/2018/08/movie-poster-coming-soon-2.png',
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.3,
                  );
                },
              ),
              InkWell(
                onTap: () {
                  viewModel.onTap(widget.watchedMoviesList, widget.movie);
                },
                child: state is Watched
                    ? Image.asset(AppAssets.bookmarkAdded)
                    : Image.asset(AppAssets.bookmarkAdd),
                //child: state is Watched ? Image.asset(AppAssets.bookmarkAdded) : Image.asset(AppAssets.bookmarkAdd),
              ),
            ],
          ),
        );
      },
    );
  }
}
