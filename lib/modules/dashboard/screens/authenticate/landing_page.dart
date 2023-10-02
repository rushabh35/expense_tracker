import 'package:expense_tracker/constants/app_constants_colors.dart';
import 'package:expense_tracker/modules/dashboard/screens/authenticate/signup_page.dart';
import 'package:expense_tracker/utils/ui/ClickableText.dart';
import 'package:flutter/material.dart';
import '../../../../utils/ui/CustomButton.dart';
import '../../../../utils/ui/CustomTextWidget.dart';
import 'login_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var sizeHeight = size.height;
    var sizeWidth = size.width;
    return  Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        Image.asset('assets/images/landing_image.png'),


          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                width: sizeWidth * 0.7,
                height: sizeHeight * 0.06,
                text: 'GET STARTED',
                onPressed: () {
                  try {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUpPage()));
                  } catch (e) {
                    print("Navigation error: $e");
                  }
                },
              ),
              SizedBox(
                height: sizeHeight * 0.05,
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomTextWidget(
                      text : 'Already have an account? ',
                      textColor : AppConstantsColors.brightWhiteColor,
                      fontSize : 14
                  ),
                  ClickableText(
                      text : 'Log In',
                      textColor : AppConstantsColors.raisedButtonColor,
                      fontSize : 14,
                      onPressed: () {
                        Navigator
                            .of(context).push(MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                      },
                  ),
                ],
              ),
            ],
          ),

        ],
      );
  }
}
