import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/model/browse_response/browse_response.dart';
import 'package:movies_app/data/repos/browse_tab_repo/browse_tab_ds.dart';
import 'package:movies_app/data/repos/browse_tab_repo/browse_tab_repo.dart';
import 'package:movies_app/ui/screens/category/category_screen.dart';
import 'package:movies_app/ui/screens/main/tabs/browse/browse_tab_states.dart';
import 'package:movies_app/ui/screens/main/tabs/browse/browse_tab_view_model.dart';
import 'package:movies_app/ui/util/app_assets.dart';
import 'package:movies_app/ui/util/app_colors.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({super.key});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  BrowseTabViewModel browseTabViewModel =
      BrowseTabViewModel(BrowseTabRepo(BrowseDataSource()));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      browseTabViewModel.getGenres();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Text(
            "Browse Category",
            style: TextStyle(
              fontSize: 22,
              color: AppColors.white,
            ),
          ),
        ),
        BlocBuilder(
          bloc: browseTabViewModel,
          builder: (context, state) {
            if (state is BrowseTabISuccessState) {
              return buildBrowseTab(context, state.list);
            } else if (state is BrowseTabErrorState) {
              return errorView();
            } else {
              return loadingView();
            }
          },
        ),
      ],
    );
  }

  Widget buildBrowseTab(BuildContext context, List<Genre> list) {
    return Expanded(
      child: GridView.builder(
        itemCount: list.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: MediaQuery.of(context).size.height * 0.17,
        ),
        itemBuilder: (context, index) => InkWell(
            onTap: () {
              Navigator.pushNamed(context, CategoryScreen.routeName,
                  arguments: list[index]);
            },
            child: buildCategoryWidget(context, list[index].name!)),
      ),
    );
  }

  Widget buildCategoryWidget(BuildContext context, String category) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.17,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                AppAssets.browseBg,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromRGBO(0, 0, 0, 180),
            ),
            width: double.infinity,
            height: double.infinity,
          ),
          Text(category,
              style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
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
