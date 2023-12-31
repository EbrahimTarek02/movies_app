import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/ui/screens/main/main_screen_view_model.dart';
import 'package:movies_app/ui/screens/main/tabs/browse/browse_tab.dart';
import 'package:movies_app/ui/screens/main/tabs/home/home_tab.dart';
import 'package:movies_app/ui/screens/main/tabs/search/search_tab.dart';
import 'package:movies_app/ui/screens/states.dart';
import 'package:movies_app/ui/screens/main/tabs/watch_list/watch_list_tab.dart';
import 'package:movies_app/ui/util/app_assets.dart';
import 'package:movies_app/ui/util/app_colors.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = 'main';

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MainScreenViewModel viewModel = MainScreenViewModel();

  final List<Widget> tabs = [
    const HomeTab(),
    const SearchTab(),
    const BrowseTab(),
    const WatchListTab()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenViewModel, MainScreenStates>(
        bloc: viewModel,
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.backgroundColor,
              bottomNavigationBar:
                  bottomNavBarBuilder(state as MainScreenInitialState),
              body: tabs[state.currentIndex],
            ),
          );
        });
  }

  Widget bottomNavBarBuilder(MainScreenInitialState state) {
    return Theme(
      data: ThemeData()
          .copyWith(canvasColor: AppColors.bottomNavBarBackgroundColor),
      child: BottomNavigationBar(
        unselectedItemColor: AppColors.bottomNavBarUnSelectedItemColor,
        selectedItemColor: AppColors.accent,
        showUnselectedLabels: true,
        currentIndex: state.currentIndex,
        onTap: (newIndex) {
          viewModel.changeBottomNavBarIndex(newIndex);
        },
        items: const [
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(AppAssets.homeIcon),
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(AppAssets.searchIcon),
              ),
              label: 'Search'),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(AppAssets.browseIcon),
              ),
              label: 'Browse'),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(AppAssets.watchListIcon),
              ),
              label: 'WatchList'),
        ],
      ),
    );
  }
}
