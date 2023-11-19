import 'package:movies_app/data/model/watch_list_data_model/watch_list_dm.dart';

abstract class MainScreenStates {}

class MainScreenInitialState extends MainScreenStates {
  int currentIndex;

  MainScreenInitialState(this.currentIndex);
}

class MainScreenErrorState extends MainScreenStates {}

class MainScreenSuccessState extends MainScreenStates {
  List<WatchListDM> list;

  MainScreenSuccessState(this.list);
}
