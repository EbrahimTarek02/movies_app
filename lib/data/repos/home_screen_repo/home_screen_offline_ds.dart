import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/data/model/watch_list_data_model/watch_list_dm.dart';

class HomeScreenOfflineDS {
  Future<List<WatchListDM>> getWatchedList() async {
    List<WatchListDM> watchedList = [];

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(WatchListDM.collectionName);

    QuerySnapshot querySnapshot = await collectionReference.get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      Map<String, dynamic> json =
          querySnapshot.docs[i].data() as Map<String, dynamic>;
      watchedList.add(WatchListDM.fromJson(json));
    }
    return watchedList;
  }
}
