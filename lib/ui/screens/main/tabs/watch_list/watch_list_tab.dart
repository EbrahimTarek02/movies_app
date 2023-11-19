import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:movies_app/data/model/movies_response/movies_response.dart';
import 'package:movies_app/data/model/watch_list_data_model/watch_list_dm.dart';
import 'package:movies_app/data/repos/watch_list_repo/watch_list_ds.dart';
import 'package:movies_app/data/repos/watch_list_repo/watch_list_repo.dart';
import 'package:movies_app/ui/screens/main/tabs/watch_list/watch_list_states.dart';
import 'package:movies_app/ui/screens/main/tabs/watch_list/watch_list_view_model.dart';
import 'package:movies_app/ui/util/app_assets.dart';
import 'package:movies_app/ui/util/app_colors.dart';

class WatchListTab extends StatefulWidget {
  const WatchListTab({super.key});

  @override
  State<WatchListTab> createState() => _WatchListTabState();
}

class _WatchListTabState extends State<WatchListTab> {
  WatchListTabViewModel watchListTabViewModel =
      WatchListTabViewModel(WatchListRepo(WatchListDataSource()));

  @override
  void initState() {
    super.initState();
    watchListTabViewModel.getWatchedList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Text(
            "Watchlist",
            style: TextStyle(
              fontSize: 22,
              color: AppColors.white,
            ),
          ),
        ),
        BlocBuilder(
          bloc: watchListTabViewModel,
          builder: (context, state) {
            if (state is WatchListTabISuccessState) {
              return buildWatchTab(state.watchedList);
            } else if (state is WatchListTabErrorState) {
              return errorView();
            } else {
              return loadingView();
            }
          },
        ),
      ],
    );
  }

  Widget buildWatchTab(List<WatchListDM> watchList) {
    return Expanded(
      child: ListView.builder(
        itemCount: watchList.length,
        itemBuilder: (context, index) => buildResultContent(
            watchList[index].result!, watchList[index].id.toString()),
      ),
    );
  }

  Widget buildResultContent(Result result, String id) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Slidable(
            endActionPane: ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: (_) {
                    watchListTabViewModel.deleteMovie(id);
                  },
                  icon: Icons.delete,
                  label: 'Delete',
                  backgroundColor: AppColors.darkGrey,
                ),
              ],
            ),
            child: Row(
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
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppAssets.noMoviesFoundIcon),
          const SizedBox(
            height: 12,
          ),
          const Text(
            "No Categories found",
            style: TextStyle(color: AppColors.white, fontSize: 13),
          ),
        ],
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
}
