import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/ui/screens/states.dart';

class MainScreenViewModel extends Cubit<MainScreenStates> {
  MainScreenViewModel() : super(MainScreenInitialState(0));

  void changeBottomNavBarIndex(int newIndex) {
    emit(MainScreenInitialState(newIndex));
  }
}