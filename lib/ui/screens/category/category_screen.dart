import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/model/browse_response/browse_response.dart';
import 'package:movies_app/data/model/movie_details_args/movies_details_args.dart';
import 'package:movies_app/data/model/movies_response/movies_response.dart';
import 'package:movies_app/data/model/watch_list_data_model/watch_list_dm.dart';
import 'package:movies_app/data/repos/category_screen_repo/categories_screen_data_source.dart';
import 'package:movies_app/data/repos/category_screen_repo/categories_screen_repo.dart';
import 'package:movies_app/ui/screens/category/category_screen_states.dart';
import 'package:movies_app/ui/screens/category/category_screen_view_model.dart';
import 'package:movies_app/ui/screens/movie_details/movie_details.dart';
import 'package:movies_app/ui/util/app_assets.dart';
import 'package:movies_app/ui/util/app_colors.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);
  static const String routeName = "categoriesScreen";

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoryScreenViewModel categoriesScreenViewModel =
      CategoryScreenViewModel(CategoryRepo(CategoryDataSource()));
  late Genre arg;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      categoriesScreenViewModel.getResults(arg.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    arg = ModalRoute.of(context)!.settings.arguments as Genre;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: AppColors.white
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text("${arg.name} Movies",
          style: TextStyle(
            color: AppColors.white,
          ),),
          centerTitle: true,
        ),
        backgroundColor: AppColors.backgroundColor,
        body: BlocBuilder(
          bloc: categoriesScreenViewModel,
          builder: (context, state) {
            if (state is CategoriesSuccessState) {
              return buildCategoriesWidget(state.list, state.watchedMoviesList);
            } else if (state is CategoriesErrorState) {
              return errorView();
            } else {
              return loadingView();
            }
          },
        ),
      ),
    );
  }

  Widget buildCategoriesWidget(
      List<Result> list, List<WatchListDM> watchedMoviesList) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) => InkWell(
          onTap: () {
            Navigator.pushNamed(context, MovieDetails.routeName,
                arguments: MovieDetailsArgs(
                    list[index].id.toString(), watchedMoviesList));
          },
          child: buildResultContent(list[index])),
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

  Widget errorView() {
    return Center(
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

  Widget loadingView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
