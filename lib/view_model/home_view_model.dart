import 'dart:developer';

import 'package:flutter/cupertino.dart';
import '../data/response/api_response.dart';
import '../model/movie_model.dart';
import '../respository/home_repository.dart';

class HomeViewViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();

  ApiResponse<MovieListModel> moviesList = ApiResponse.loading();

  setMoviesList(ApiResponse<MovieListModel> response) {
    log("@@@@@@@@ : $response");
    moviesList = response;
    notifyListeners();
  }

  Future<void> fetchMoviesListApi() async {
    setMoviesList(ApiResponse.loading());

    _myRepo.fetchMoviesList().then((value) {
      log("12345${value.movies}");
      setMoviesList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setMoviesList(ApiResponse.error(error.toString()));
    });
  }
}
