import 'package:flutter/material.dart';
import 'package:mvvm_project/view_model/servies/splash_services.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    splashServices.checkAuthentication(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Splash Screen',style: Theme.of(context).textTheme.headlineMedium,),
      )
    );
  }
}
