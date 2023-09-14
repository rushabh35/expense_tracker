import 'package:expense_tracker/constants/app_constants_colors.dart';
import 'package:expense_tracker/utils/ui/CustomBoldText.dart';
import 'package:expense_tracker/widgets/LoginTextField.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
  TextEditingController _loginController = TextEditingController();
    var size = MediaQuery.of(context).size;
    var sizeHeight = size.height;
    var sizeWidth = size.width;
    return  Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomBoldText(
              text: 'Sign in with password',
              fontSize: sizeHeight * 0.05,
              textColor: AppConstantsColors.textWhiteColor,
            ),
            LoginTextFieldWidget(controller: _loginController, hintText: 'Email'),
        ],
      ),
    );
  }
}
