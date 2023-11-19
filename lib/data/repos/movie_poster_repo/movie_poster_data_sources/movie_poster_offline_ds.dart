import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/data/model/movies_response/movies_response.dart';
import 'package:movies_app/data/model/watch_list_data_model/watch_list_dm.dart';

class MoviePosterOfflineDS {
  String addToFirestore(Result movie) {
    CollectionReference collection =
        FirebaseFirestore.instance.collection(WatchListDM.collectionName);
    DocumentReference doc = collection.doc();
    WatchListDM model = WatchListDM(id: doc.id, result: movie, isWatched: true);
    Map<String, dynamic> json = model.toJson();
    doc.set(json);
    return doc.id;
  }

  void deleteMovie(String id) {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(WatchListDM.collectionName);

    collectionReference.doc(id).delete();
  }
}
