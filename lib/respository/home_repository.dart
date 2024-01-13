

import 'dart:developer';

import 'package:mvvm_project/data/network/networkApi_service.dart';
import '../data/network/baseApi_services.dart';
import '../model/movie_model.dart';
import '../resources/app_url.dart';

class HomeRepository {

  final BaseApiServices _apiServices = NetworkApiServices();

  Future<MovieListModel> fetchMoviesList()async{

    try{

      dynamic response = await _apiServices.getGetApiResponse(AppUrl.moviesListEndPoint);
      log("7890${response}");
      return response = MovieListModel.fromJson(response);

    }catch(e){
      throw e ;
    }
  }

}