import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_project/resources/color.dart';
import 'package:mvvm_project/resources/components/round_button.dart';
import 'package:mvvm_project/utils/routes/routes_name.dart';
import 'package:mvvm_project/utils/utils.dart';
import 'package:mvvm_project/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController= TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final authViewMode = Provider.of<AuthViewModel>(context);

    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,

      ),
      body:SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              focusNode: emailFocusNode,
              decoration: const InputDecoration(
                hintText: 'Email',
                prefixIcon: Icon(Icons.email_outlined)
              ),
              onFieldSubmitted: (value){
                Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
              },
            ),
             SizedBox(height: height * .02,),
            ValueListenableBuilder(
                valueListenable: _obsecurePassword,
                builder: (context,value, child){
                  return TextFormField(
                    controller: _passwordController,
                    focusNode: passwordFocusNode,
                    obscureText: _obsecurePassword.value,
                    decoration:  InputDecoration(
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: InkWell(
                          onTap: (){
                            _obsecurePassword.value = !_obsecurePassword.value;
                          },
                            child: Icon(
                                _obsecurePassword.value ? Icons.visibility_off :
                            Icons.visibility
                            ))
                    ),
                  );
                }),
            SizedBox(height: height * .04,),
            RoundButton(
              title: 'Login',
              loading: authViewMode.loading,
              onPress: (){
                if(_emailController.text.isEmpty){
                  Utils.flushBarErrorMessage('Please enter email', context);
                }else if(_passwordController.text.isEmpty){
                  Utils.flushBarErrorMessage('Please enter Password', context);
                }else if(_passwordController.text.length < 6){
                  Utils.flushBarErrorMessage('Please enter 6 digit password', context);
                }else{
                  Map data = {
                    'email' : _emailController.text.toString(),
                    'password' : _passwordController.text.toString()
                  };
                  //   'email' : 'eve.holt@reqres.in',
                  //   'password' : 'cityslicka',
                  authViewMode.loginApi(data, context);
                  if (kDebugMode) {
                    print('api hit');
                  }
                }
              },
            ),
            SizedBox(height: height * .04,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 const Text("Don't have an account? "),
                InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, RoutesName.signUp);
                    },
                    child: const Text("Sign Up",style: TextStyle(color: AppColor.buttonColor,fontSize: 18),))
              ],
            ),

          ],
        ),
      )
    );
  }
}
