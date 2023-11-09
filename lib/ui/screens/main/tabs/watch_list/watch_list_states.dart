import 'package:movies_app/data/model/watch_list_data_model/watch_list_dm.dart';

abstract class WatchListStates {}

class WatchListTabLoadingState extends WatchListStates {}

class WatchListTabISuccessState extends WatchListStates {
  List<WatchListDM> watchedList;

  WatchListTabISuccessState(this.watchedList);
}

class WatchListTabErrorState extends WatchListStates {
  String errorText;

  WatchListTabErrorState(this.errorText);
}
