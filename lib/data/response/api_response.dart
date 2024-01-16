



import 'package:mvvm_project/data/response/status.dart';
import 'package:mvvm_project/model/movie_model.dart';

class ApiResponse<T> {

  Status status;
  T? data;
  String? message;

  ApiResponse(this.status, this.data, this.message);

  ApiResponse.loading() : status = Status.LOADING;
  ApiResponse.completed(this.data) : status = Status.COMPLETED;
  ApiResponse.error(String string) : status = Status.ERROR;

  @override
  String toString(){
    return "Status : $status \n Message : $message \n Data : $data";
  }
}