import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/model/movies_response/movies_response.dart';
import 'package:movies_app/ui/screens/main/tabs/search/search_tab_states.dart';
import 'package:movies_app/ui/screens/main/tabs/search/search_tab_view_model.dart';
import 'package:movies_app/ui/screens/movie_details/movie_details.dart';
import 'package:movies_app/ui/util/app_assets.dart';
import 'package:movies_app/ui/util/app_colors.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  SearchTabViewModel searchTabViewModel = SearchTabViewModel();
  late Widget currentState;

  @override
  Widget build(BuildContext context) {
    Widget currentWidget;
    return Container(
      color: AppColors.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              onChanged: (text) {
                searchTabViewModel.getResults(text);
              },
              style: const TextStyle(color: AppColors.white, fontSize: 14),
              decoration: InputDecoration(
                hintText: "Search",
                filled: true,
                fillColor: AppColors.darkGrey,
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.white,
                ),
                hintStyle: const TextStyle(
                  color: AppColors.white,
                  fontSize: 14,
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: AppColors.white)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: AppColors.white)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder(
              bloc: searchTabViewModel,
              builder: (context, state) {
                if (state is SearchTabSuccessState) {
                  currentWidget = Expanded(
                    child: ListView.builder(
                      itemCount: state.result.length,
                      itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, MovieDetails.routeName,
                                arguments: state.result[index].id.toString());
                          },
                          child: buildResultContent(state.result[index])),
                    ),
                  );
                } else if (state is SearchTabErrorState) {
                  currentWidget = errorView();
                } else if (state is SearchTabLoadingState) {
                  currentWidget = loadingView();
                } else {
                  currentWidget = const SizedBox();
                }
                return currentWidget;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget loadingView() {
    return const Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
        ],
      ),
    );
  }

  Widget errorView() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppAssets.noMoviesFoundIcon),
          const SizedBox(
            height: 12,
          ),
          const Text(
            "No movies found",
            style: TextStyle(color: AppColors.white, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget buildResultContent(Result result) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.12,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://image.tmdb.org/t/p/w500${result.backdropPath}",
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Image.network(
                            "https://michaelnakache.com/wp-content/uploads/2018/08/movie-poster-coming-soon-2.png",
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "${result.title}",
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: AppColors.white,
                        fontSize: 15,
                      ),
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${result.releaseDate}",
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Color.fromARGB(170, 255, 255, 255),
                        fontSize: 13,
                      ),
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      "${result.overview}",
                      style: const TextStyle(
                        color: Color.fromARGB(170, 255, 255, 255),
                        fontSize: 13,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 1,
            color: AppColors.divider,
          ),
        ],
      ),
    );
  }
}
