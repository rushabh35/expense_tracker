import 'dart:convert';

import 'package:expense_tracker/constants/app_constants_colors.dart';
import 'package:expense_tracker/modules/dashboard/screens/HomeScreen.dart';
import 'package:expense_tracker/modules/dashboard/screens/authenticate/signup_page.dart';
import 'package:expense_tracker/utils/ui/ClickableText.dart';
import 'package:expense_tracker/utils/ui/CustomBoldText.dart';
import 'package:expense_tracker/utils/ui/icon_button_widget.dart';
import 'package:expense_tracker/widgets/LoginTextField.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/ui/CustomButton.dart';
import '../../../../utils/ui/CustomTextWidget.dart';
import '../../../../widgets/PasswordTextField.dart';
import 'landing_page.dart';
import 'package:http/http.dart' as http;
import '../../../../config/config.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passWordController = TextEditingController();
  bool _isNotValid = false;
   SharedPreferences? prefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
  }
  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }
  void loginUser() async {
    if(_emailController.text.isNotEmpty && _passWordController.text.isNotEmpty ) {
      var regBody = {
        "email" : _emailController.text,
        "password" : _passWordController.text
      };

      var response = await http.post(Uri.parse(login),
        headers : {"Content-type" : "application/json"},
        body : jsonEncode(regBody),
      );

      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);

      if(jsonResponse['status']){
        var myToken = jsonResponse['token'];
        prefs?.setString('token', myToken);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>  HomeScreen(token: myToken,)));
        _emailController.text = "";
        _passWordController.text = "";
      } else {

        print("Something went wrong");
      }
    } else {
      setState(() {
        _isNotValid = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {


    var size = MediaQuery.of(context).size;
    var sizeHeight = size.height;
    var sizeWidth = size.width;
    return  Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // SizedBox(height: sizeHeight * 0.2),
            CustomBoldText(
                text: 'Sign in with password',
                fontSize: sizeHeight * 0.06,
                textColor: AppConstantsColors.brightWhiteColor,
              ),

            LoginTextFieldWidget(controller: _emailController, hintText: 'Email', errorText : _isNotValid ? "Enter Email Field" : null,),

            PasswordTextField(controller: _passWordController, hintText: 'Password', errorText : _isNotValid ? "Enter password Field" : null,),


            CustomButton(
              text: 'SIGN IN',
              onPressed: () {
                loginUser();
                // try {
                //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LandingPage()));
                // } catch (e) {
                //   print("Navigation error: $e");
                // }
              },
              width: sizeWidth * 0.92,
              height: sizeHeight * 0.06,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: sizeWidth * 0.25,
                  height: 1, // Adjust the height as needed
                  color: AppConstantsColors.grey, // Set the color here
                ),
                const CustomTextWidget(
                  text: 'Or continue with',
                  textColor: AppConstantsColors.grey,
                ),
                Container(
                  width: sizeWidth * 0.25,
                  height: 1, // Adjust the height as needed
                  color: AppConstantsColors.grey, // Set the color here
                ),
              ],
            ),

             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomTextWidget(
                    text: 'Dont have an account? ',
                  textColor: AppConstantsColors.whiteColor,
                ),
                ClickableText(
                  text : 'Sign Up',
                  textColor : AppConstantsColors.raisedButtonColor,
                  fontSize : 14,
                  onPressed: () {
                    Navigator
                        .of(context).push(MaterialPageRoute(
                        builder: (context) => const SignUpPage()));
                  },
                )
              ],
            )



          ],
        ),
      ),
    );
  }
}
