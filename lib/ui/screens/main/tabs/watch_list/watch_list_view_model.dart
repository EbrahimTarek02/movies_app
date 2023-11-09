import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/model/watch_list_data_model/watch_list_dm.dart';
import 'package:movies_app/data/repos/watch_list_repo/watch_list_repo.dart';
import 'package:movies_app/ui/screens/main/tabs/watch_list/watch_list_states.dart';
import 'package:movies_app/ui/screens/main/tabs/watch_list/watch_list_tab.dart';

class WatchListTabViewModel extends Cubit {
  WatchListRepo watchListRepo;

  WatchListTabViewModel(this.watchListRepo) : super(WatchListStates);

  void getWatchedList() async {
    emit(WatchListTabLoadingState());

    List<WatchListDM> list = await watchListRepo.getWatchedList();
    if (list.isNotEmpty) {
      emit(WatchListTabISuccessState(list));
    } else {
      emit(WatchListTabErrorState("Empty"));
    }
  }
}
