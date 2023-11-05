import 'package:movies_app/data/model/browse_response/browse_response.dart';

abstract class BrowseTabStates {}

class BrowseTabLoadingState extends BrowseTabStates {}

class BrowseTabISuccessState extends BrowseTabStates {
  List<Genre> list;

  BrowseTabISuccessState(this.list);
}

class BrowseTabErrorState extends BrowseTabStates {
  String errorText;

  BrowseTabErrorState(this.errorText);
}
