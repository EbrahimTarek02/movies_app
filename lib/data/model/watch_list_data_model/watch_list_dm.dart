import 'package:movies_app/data/model/movies_response/movies_response.dart';

class WatchListDM {
  static const String collectionName = 'watched movies';
  int? id;
  bool? isWatched;
  Result? result;

  WatchListDM({
    this.id,
    this.isWatched,
    this.result,
  });

  WatchListDM.fromJson(dynamic json) {
    id = json['id'];
    isWatched = json['isWatched'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['isWatched'] = isWatched;
    if (result != null) {
      map['result'] = result?.toJson();
    }
    return map;
  }
}
