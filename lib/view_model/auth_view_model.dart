
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm_project/respository/auth_repository.dart';
import 'package:mvvm_project/utils/routes/routes_name.dart';
import 'package:mvvm_project/utils/utils.dart';

class AuthViewModel with ChangeNotifier{

  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  bool _signUploading = false;
  bool get signUploading => _signUploading;

  setSignUploading(bool value){
    _signUploading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context)async{

    setLoading(true);
    _myRepo.loginApi(data).then((value) {
      setLoading(false);
      Utils.flushBarErrorMessage('Login Successfully', context);
      Navigator.pushNamed(context,RoutesName.homeMovie);
      if(kDebugMode){
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);

      if(kDebugMode){
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }

  Future<void> signUpApi(dynamic data, BuildContext context)async{

    setSignUploading(true);
    _myRepo.signUpApi(data).then((value) {
      setSignUploading(false);
      Utils.flushBarErrorMessage('SignUp Successfully', context);
      Navigator.pushNamed(context,RoutesName.home);
      if(kDebugMode){
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setSignUploading(false);

      if(kDebugMode){
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }
}