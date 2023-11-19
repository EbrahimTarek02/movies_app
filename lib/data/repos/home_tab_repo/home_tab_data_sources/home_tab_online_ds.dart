import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import 'package:movies_app/data/model/movies_response/movies_response.dart';
import 'package:movies_app/data/model/watch_list_data_model/watch_list_dm.dart';

class HomeTabOnlineDS {
  static const String baseUrl = 'https://api.themoviedb.org';
  static const String apiKey = 'cb223dfe2295c5cc9acf379eca60015b';

  Future<MoviesResponse> getPopularMovies() async {
    try {
      const String endPoint = '/3/movie/popular';
      const String url = '$baseUrl$endPoint?api_key=$apiKey';
      Response response = await get(Uri.parse(url));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        Map<String, dynamic> json = jsonDecode(response.body);
        MoviesResponse popularResponse = MoviesResponse.fromJson(json);
        return popularResponse;
      }
      throw Exception('Something went wrong please try again later');
    } catch (error) {
      rethrow;
    }
  }

  Future<MoviesResponse> getUpcomingMovies() async {
    try {
      const String endPoint = '/3/movie/upcoming';
      const String url = '$baseUrl$endPoint?api_key=$apiKey';
      Response response = await get(Uri.parse(url));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        Map json = jsonDecode(response.body);
        MoviesResponse upcomingResponse = MoviesResponse.fromJson(json);
        return upcomingResponse;
      } else {
        throw Exception('Something went wrong please try again later');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<MoviesResponse> getTopRatedMovies() async {
    try {
      const String endPoint = '/3/movie/top_rated';
      const String url = '$baseUrl$endPoint?api_key=$apiKey';
      Response response = await get(Uri.parse(url));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        Map json = jsonDecode(response.body);
        MoviesResponse topRatedResponse = MoviesResponse.fromJson(json);
        return topRatedResponse;
      } else {
        throw Exception('Something went wrong please try again later');
      }
    } catch (e) {
      rethrow;
    }
  }

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
