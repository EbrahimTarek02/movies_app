import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/data/model/movie_details_args/movies_details_args.dart';
import 'package:movies_app/data/model/movies_response/movies_response.dart';
import 'package:movies_app/data/model/watch_list_data_model/watch_list_dm.dart';
import 'package:movies_app/ui/common/movie_poster_view.dart';
import 'package:movies_app/ui/screens/movie_details/movie_details.dart';
import 'package:movies_app/ui/util/app_colors.dart';

class ListOfMoviesItemView extends StatelessWidget {
  final List<Result> moviesList;
  final List<WatchListDM> watchedMoviesList;
  final int index;

  const ListOfMoviesItemView(
      this.watchedMoviesList, this.moviesList, this.index,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, MovieDetails.routeName,
            arguments: MovieDetailsArgs(
                moviesList[index].id.toString(), watchedMoviesList));
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8.0),
        ),
        width: MediaQuery.of(context).size.width * 0.28,
        padding: const EdgeInsets.only(right: 14.0),
        child: Card(
          color: AppColors.primary,
          clipBehavior: Clip.hardEdge,
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child:
                    MoviePosterView(watchedMoviesList, moviesList[index], true),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rate_rounded,
                          color: AppColors.accent,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          moviesList[index].voteAverage.toString(),
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 10.0,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.normal)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Text(
                      moviesList[index].title.toString(),
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 10.0,
                              color: AppColors.white,
                              fontWeight: FontWeight.normal)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      moviesList[index].releaseDate.toString(),
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 10.0,
                              color: AppColors.white,
                              fontWeight: FontWeight.normal)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
