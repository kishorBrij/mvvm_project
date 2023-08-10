
import 'package:mvvm_project/data/network/baseApi_services.dart';
import 'package:mvvm_project/data/network/networkApi_service.dart';
import 'package:mvvm_project/resources/app_url.dart';

class AuthRepository {

final BaseApiServices _apiServices = NetworkApiServices();

Future<dynamic> loginApi(dynamic data)async{
  try{

    dynamic response = await _apiServices.getPostApiResponse(AppUrl.loginUrl, data);
    return response;
  }catch(e){
    rethrow;
  }
}

Future<dynamic> signUpApi(dynamic data)async{
  try{

    dynamic response = await _apiServices.getPostApiResponse(AppUrl.registerApiUrl, data);
    return response;
  }catch(e){
    throw e;
  }
}
}