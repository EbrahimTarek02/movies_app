class WatchListDM {
  String? id;
  String? movieId;
  bool? isWatched;

  static const String collectionName = 'watched movies';

  WatchListDM({required this.id, required this.movieId, required this.isWatched});

  WatchListDM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    movieId = json['movieId'];
    isWatched = json['isWatched'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['movieId'] = movieId;
    map['isWatched'] = isWatched;
    return map;
  }
}