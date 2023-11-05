import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/model/browse_response/browse_response.dart';
import 'package:movies_app/data/repos/browse_tab_repo/browse_tab_repo.dart';
import 'package:movies_app/ui/screens/main/tabs/browse/browse_tab_states.dart';

class BrowseTabViewModel extends Cubit {
  BrowseTabRepo browseTabRepo;

  BrowseTabViewModel(this.browseTabRepo) : super(BrowseTabStates);

  void getGenres() async {
    emit(BrowseTabLoadingState());
    try {
      BrowseResponse categoriesResponse = await browseTabRepo.getGenres();
      if (categoriesResponse.genres?.isNotEmpty == true) {
        emit(BrowseTabISuccessState(categoriesResponse.genres!));
      }
    } catch (error) {
      emit(BrowseTabErrorState(error.toString()));
    }
  }
}
