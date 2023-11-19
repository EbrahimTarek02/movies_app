import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/data/model/movie_details_args/movies_details_args.dart';
import 'package:movies_app/ui/common/list_of_movies_item_view.dart';
import 'package:movies_app/ui/common/movie_image_view.dart';
import 'package:movies_app/ui/common/movie_poster_view.dart';
import 'package:movies_app/ui/screens/main/tabs/home/home_tab_states.dart';
import 'package:movies_app/ui/screens/main/tabs/home/home_tab_view_model.dart';
import 'package:movies_app/ui/screens/movie_details/movie_details.dart';
import 'package:movies_app/ui/util/app_colors.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  HomeTabViewModel popularViewModel = HomeTabViewModel();
  HomeTabViewModel upcomingViewModel = HomeTabViewModel();
  HomeTabViewModel topRatedViewModel = HomeTabViewModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      popularViewModel.getPopularMovies();
      upcomingViewModel.getUpcomingMovies();
      topRatedViewModel.getTopRatedMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .34,
            child: BlocBuilder<HomeTabViewModel, HomeTabStates>(
                bloc: popularViewModel,
                builder: (context, state) {
                  if (state is HomeTabLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.accent,
                      ),
                    );
                  } else if (state is HomeTabSuccessState) {
                    return CarouselSlider(
                      options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 1,
                          height: double.infinity),
                      items: state.moviesResponse.results!
                          .map((e) => GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, MovieDetails.routeName,
                                      arguments: MovieDetailsArgs(
                                          e.id.toString(),
                                          state.watchedMoviesList));
                                },
                                child: Stack(
                                  alignment: AlignmentDirectional.bottomStart,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Expanded(
                                          child: MovieImageViewer(e
                                                  .backdropPath ??
                                              'https://michaelnakache.com/wp-content/uploads/2018/08/movie-poster-coming-soon-2.png'),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              bottom: 10.0,
                                              top: 10.0),
                                          child: Text(
                                            e.originalTitle ??
                                                "Can/'t load movie title",
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.normal,
                                                color: AppColors.white,
                                              ),
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              bottom: 20.0),
                                          child: Text(
                                            e.releaseDate ??
                                                "Can/'t load movie release date",
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.normal,
                                                color: AppColors.white,
                                              ),
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: MoviePosterView(
                                          state.watchedMoviesList, e, false),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    );
                  } else {
                    return Container(
                      color: AppColors.accent,
                      child: const Text('Error'),
                    );
                  }
                }),
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .25,
            child: BlocBuilder<HomeTabViewModel, HomeTabStates>(
              bloc: upcomingViewModel,
              builder: (context, state) {
                if (state is HomeTabLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.accent,
                    ),
                  );
                } else if (state is HomeTabSuccessState) {
                  return Container(
                    color: AppColors.primary,
                    padding: const EdgeInsets.only(
                        top: 15.0, bottom: 13.0, left: 27.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'New Releases',
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.white)),
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(top: 13.0),
                            itemCount: state.moviesResponse.results!.length,
                            itemBuilder: (context, index) =>
                                listViewBuilder(state, index),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    color: AppColors.accent,
                    child: const Text('Error'),
                  );
                }
              },
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .27,
            child: BlocBuilder<HomeTabViewModel, HomeTabStates>(
              bloc: topRatedViewModel,
              builder: (context, state) {
                if (state is HomeTabLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.accent,
                    ),
                  );
                } else if (state is HomeTabSuccessState) {
                  return Container(
                    color: AppColors.primary,
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 13.0, left: 27.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Recommended',
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.white)),
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(top: 4.0),
                            itemCount: state.moviesResponse.results!.length,
                            itemBuilder: (context, index) =>
                                ListOfMoviesItemView(state.watchedMoviesList,
                                    state.moviesResponse.results!, index),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    color: AppColors.accent,
                    child: const Text('Error'),
                  );
                }
              },
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }

  Widget listViewBuilder(HomeTabSuccessState state, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 14.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, MovieDetails.routeName,
              arguments: MovieDetailsArgs(
                  state.moviesResponse.results![index].id.toString(),
                  state.watchedMoviesList));
        },
        child: MoviePosterView(state.watchedMoviesList,
            state.moviesResponse.results![index], true),
      ),
    );
  }
}
