import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/data/model/movie_details_args/movies_details_args.dart';
import 'package:movies_app/data/model/movies_response/movies_response.dart';
import 'package:movies_app/ui/common/list_of_movies_item_view.dart';
import 'package:movies_app/ui/common/movie_image_view.dart';
import 'package:movies_app/ui/common/movie_poster_view.dart';
import 'package:movies_app/ui/screens/category/category_screen.dart';
import 'package:movies_app/ui/screens/main/main_screen.dart';
import 'package:movies_app/ui/screens/movie_details/movie_details_states.dart';
import 'package:movies_app/ui/screens/movie_details/movie_details_view_model.dart';
import 'package:movies_app/ui/util/app_colors.dart';

class MovieDetails extends StatefulWidget {
  static const String routeName = 'movie details';

  const MovieDetails({super.key});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  MovieDetailsViewModel viewModel = MovieDetailsViewModel();
  MovieDetailsViewModel similarViewModel = MovieDetailsViewModel();
  late MovieDetailsArgs args;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.getMovieDetails(args.movieId.toString());
      similarViewModel.getSimilarMovies(args.movieId.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as MovieDetailsArgs;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, MainScreen.routeName);
        return false;
      },
      child: BlocBuilder<MovieDetailsViewModel, MovieDetailsStates>(
          bloc: viewModel,
          builder: (context, state) {
            if (state is MovieDetailsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MovieDetailsSuccessState) {
              return SafeArea(
                  child: Scaffold(
                      backgroundColor: AppColors.backgroundColor,
                      appBar: AppBar(
                        backgroundColor: AppColors.appBarBackgroundColor,
                        title: Text(
                          state.movieDetailsResponse.title ?? "Movie Title",
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.white)),
                        ),
                      ),
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: MovieImageViewer(
                                    state.movieDetailsResponse.backdropPath ??
                                        'https://michaelnakache.com/wp-content/uploads/2018/08/movie-poster-coming-soon-2.png',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 22, top: 13.0, bottom: 8.0),
                                  child: Text(
                                    state.movieDetailsResponse.title ??
                                        "Movie Title",
                                    style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.normal,
                                            color: AppColors.white)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 22,
                                    bottom: 20,
                                  ),
                                  child: Text(
                                    state.movieDetailsResponse.releaseDate ??
                                        "Movie Release Date",
                                    style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.normal,
                                            color: AppColors
                                                .bottomNavBarUnSelectedItemColor)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 20.0, bottom: 20.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MoviePosterView(
                                            args.watchedMoviesList,
                                            Result(
                                                posterPath: state
                                                    .movieDetailsResponse
                                                    .posterPath,
                                                title: state
                                                    .movieDetailsResponse.title,
                                                releaseDate: state
                                                    .movieDetailsResponse
                                                    .releaseDate,
                                                overview: state
                                                    .movieDetailsResponse
                                                    .overview,
                                                backdropPath: state
                                                    .movieDetailsResponse
                                                    .backdropPath),
                                            false),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 11.0),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: state
                                                              .movieDetailsResponse
                                                              .genres!
                                                              .length >
                                                          3
                                                      ? MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.11
                                                      : MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.06,
                                                  width: double.infinity,
                                                  child: GridView.builder(
                                                      itemCount: state
                                                          .movieDetailsResponse
                                                          .genres!
                                                          .length,
                                                      gridDelegate:
                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount: 3,
                                                              childAspectRatio:
                                                                  2.0,
                                                              crossAxisSpacing:
                                                                  9.0,
                                                              mainAxisSpacing:
                                                                  6.0),
                                                      itemBuilder: (context,
                                                              index) =>
                                                          gridViewBuilder(
                                                              state, index)),
                                                ),
                                                Text(
                                                  state.movieDetailsResponse
                                                          .overview ??
                                                      "Movie OverView",
                                                  style: GoogleFonts.inter(
                                                      textStyle: const TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: AppColors
                                                              .bottomNavBarUnSelectedItemColor)),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.star_rate_rounded,
                                                      size: 25,
                                                      color: AppColors.accent,
                                                    ),
                                                    Text(
                                                      state.movieDetailsResponse
                                                          .voteAverage
                                                          .toString(),
                                                      style: GoogleFonts.poppins(
                                                          textStyle:
                                                              const TextStyle(
                                                                  fontSize:
                                                                      18.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: AppColors
                                                                      .white)),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  BlocBuilder<MovieDetailsViewModel,
                                          MovieDetailsStates>(
                                      bloc: similarViewModel,
                                      builder: (context, moviesState) {
                                        if (moviesState
                                            is MovieDetailsLoadingState) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        } else if (moviesState
                                            is MovieDetailsListSuccessState) {
                                          return Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.28,
                                            color: AppColors.primary,
                                            padding: const EdgeInsets.only(
                                                bottom: 13.0,
                                                left: 22.0,
                                                top: 10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Text(
                                                  'More Like This',
                                                  style: GoogleFonts.inter(
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 15.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: AppColors
                                                                  .white)),
                                                ),
                                                Expanded(
                                                  child: ListView.builder(
                                                      padding: const EdgeInsets
                                                          .only(top: 15.0),
                                                      scrollDirection: Axis
                                                          .horizontal,
                                                      itemCount: moviesState
                                                          .moviesResponse
                                                          .results!
                                                          .length,
                                                      itemBuilder: (context,
                                                              index) =>
                                                          ListOfMoviesItemView(
                                                              args
                                                                  .watchedMoviesList,
                                                              moviesState
                                                                  .moviesResponse
                                                                  .results!,
                                                              index)),
                                                ),
                                              ],
                                            ),
                                          );
                                        } else {
                                          return const Text('Error22');
                                        }
                                      })
                                ],
                              ),
                            ),
                          ),
                        ],
                      )));
            } else {
              return const Center(
                child: Text('Error'),
              );
            }
          }),
    );
  }

  Widget gridViewBuilder(MovieDetailsSuccessState state, int index) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.0),
      onTap: () {
        Navigator.pushNamed(context, CategoryScreen.routeName,
            arguments: state.movieDetailsResponse.genres![index]);
      },
      child: Container(
        decoration: BoxDecoration(
            border:
                Border.all(color: AppColors.bottomNavBarUnSelectedItemColor),
            borderRadius: BorderRadius.circular(12.0)),
        child: Center(
          child: Text(
            state.movieDetailsResponse.genres![index].name ?? "Type",
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.normal,
                  color: AppColors.bottomNavBarUnSelectedItemColor),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
