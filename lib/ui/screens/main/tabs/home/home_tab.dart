import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/ui/common/movie_image_view.dart';
import 'package:movies_app/ui/common/movie_poster_view.dart';
import 'package:movies_app/ui/screens/main/tabs/home/home_tab_states.dart';
import 'package:movies_app/ui/screens/main/tabs/home/home_tab_view_model.dart';
import 'package:movies_app/ui/util/app_colors.dart';

class HomeTab extends StatefulWidget {
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
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: BlocBuilder<HomeTabViewModel, HomeTabStates>(
            bloc: popularViewModel,
            builder: (context, state) {
              if (state is HomeTabLoadingState){
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.accent,
                  ),
                );
              }
              else if (state is HomeTabSuccessState) {
                return CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    height: double.infinity
                  ),
                  items: state.moviesResponse.results!.map((e) => GestureDetector(
                    onTap: () {},
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            MovieImageViewer(e.backdropPath ?? "data:image/jpeg;base64,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"),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * 0.4,
                                  bottom: 10.0,
                                  top: 10.0
                              ),
                              child: Text(
                                e.originalTitle ?? "Can/'t load movie title",
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
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
                                  left: MediaQuery.of(context).size.width * 0.4,
                                  bottom: 20.0
                              ),
                              child: Text(
                                e.releaseDate ?? "Can/'t load movie release date",
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
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
                          padding: const EdgeInsets.only(left: 15.0),
                          child: MoviePosterView(
                            e.posterPath ?? "data:image/jpeg;base64,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",
                            false
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                );
              }
              else {
                return Container(color: AppColors.accent, child: Text('Error'),);
              }
            }
          ),
        ),
        SizedBox(height: 20.0,),
        Expanded(
          flex: 3,
          child: BlocBuilder<HomeTabViewModel, HomeTabStates>(
            bloc: upcomingViewModel,
            builder: (context, state) {
              if (state is HomeTabLoadingState) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.accent,
                  ),
                );
              }
              else if (state is HomeTabSuccessState) {
                return Container(
                  color: AppColors.primary,
                  padding: EdgeInsets.only(
                    top: 15.0,
                    bottom: 13.0,
                    left: 27.0
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'New Releases',
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal,
                            color: AppColors.white
                          )
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(top: 13.0),
                          itemCount: state.moviesResponse.results!.length,
                          itemBuilder: (context, index) => listViewBuilder(state, index),
                        ),
                      ),
                    ],
                  ),
                );
              }
              else {
                return Container(color: AppColors.accent, child: Text('Error'),);
              }
            },
          ),
        ),
        SizedBox(height: 20.0,),
        Expanded(
          flex: 3,
          child: BlocBuilder<HomeTabViewModel, HomeTabStates>(
            bloc: topRatedViewModel,
            builder: (context, state) {
              if (state is HomeTabLoadingState) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.accent,
                  ),
                );
              }
              else if (state is HomeTabSuccessState) {
                return Container(
                  color: AppColors.primary,
                  padding: EdgeInsets.only(
                      top: 8.0,
                      bottom: 13.0,
                      left: 27.0
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Recommended',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.normal,
                                color: AppColors.white
                            )
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(top: 4.0),
                          itemCount: state.moviesResponse.results!.length,
                          itemBuilder: (context, index) => upcomingListViewBuilder(state, index),
                        ),
                      ),
                    ],
                  ),
                );
              }
              else {
                return Container(color: AppColors.accent, child: Text('Error'),);
              }
            },
          ),
        ),
        SizedBox(height: 10.0,),
      ],
    );
  }

  Widget listViewBuilder(HomeTabSuccessState state, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 14.0),
      child: GestureDetector(
        onTap: () {},
        child: MoviePosterView(
          state.moviesResponse.results![index].posterPath ?? "",
          true
        ),
      ),
    );
  }

  Widget upcomingListViewBuilder(HomeTabSuccessState state, int index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8.0),
        ),
        width: MediaQuery.of(context).size.width * 0.25,
        padding: const EdgeInsets.only(right: 14.0),
        child: Card(
          color: AppColors.primary,
          clipBehavior: Clip.hardEdge,
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: MoviePosterView(
                    state.moviesResponse.results![index].posterPath ?? "",
                    true
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star_rate_rounded,
                          color: AppColors.accent,
                          size: 18,
                        ),
                        SizedBox(width: 4.0,),
                        Text(
                          state.moviesResponse.results![index].voteAverage.toString(),
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 10.0,
                              color: AppColors.white,
                              fontWeight: FontWeight.normal
                            )
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Text(
                      state.moviesResponse.results![index].title.toString(),
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 10.0,
                              color: AppColors.white,
                              fontWeight: FontWeight.normal
                          )
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      state.moviesResponse.results![index].releaseDate.toString(),
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 10.0,
                              color: AppColors.white,
                              fontWeight: FontWeight.normal
                          )
                      ),
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
