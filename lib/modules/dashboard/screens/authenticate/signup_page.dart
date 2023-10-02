
import 'dart:convert';
import 'dart:io';
import 'package:expense_tracker/constants/app_constants_colors.dart';
import 'package:expense_tracker/modules/dashboard/screens/authenticate/login_page.dart';
import 'package:expense_tracker/utils/ui/CustomBoldText.dart';
import 'package:expense_tracker/utils/ui/icon_button_widget.dart';
import 'package:expense_tracker/widgets/LoginTextField.dart';
import 'package:flutter/material.dart';

import '../../../../config/config.dart';
import '../../../../utils/ui/ClickableText.dart';
import '../../../../utils/ui/CustomButton.dart';
import '../../../../utils/ui/CustomTextWidget.dart';
import '../../../../widgets/PasswordTextField.dart';
import 'landing_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();

}

class _SignUpPageState extends State<SignUpPage> {
  //late File _profileImage; // Store the selected profile image file
  final TextEditingController _passWordController = TextEditingController();
  // TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  bool _isNotValid = false;

  void registerUser() async {
    if(_emailController.text.isNotEmpty && _passWordController.text.isNotEmpty && _numberController.text.isNotEmpty) {
      var regBody = {
        "email" : _emailController.text,
        "phoneNumber" : _numberController.text,
        "password" : _passWordController.text
      };

      var response = await http.post(Uri.parse(registration),
          headers : {"Content-type" : "application/json"},
          body : jsonEncode(regBody),
      );

      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);

      if(jsonResponse['status']){
        Navigator
            .of(context).push(MaterialPageRoute(
            builder: (context) => const LoginPage()));
        _emailController.text = "";
        _passWordController.text = "";
        _numberController.text = "";
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

    // Function to select an image from the gallery
     File? _profileImage; // Store the selected profile image file

    // Function to select an image from the gallery
    Future<void> _pickProfileImage() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        // The user picked an image, update the profile image
        setState(() {
          _profileImage = File(pickedFile.path);
        });
      }
    }


    var size = MediaQuery.of(context).size;
    var sizeHeight = size.height;
    var sizeWidth = size.width;
    return  Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(sizeHeight * 0.05), // Set the desired app bar height
        child: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.grey,
          ),
          title: const Text('Profile',

            style: TextStyle(
              fontSize: 18,
              color: AppConstantsColors.whiteColor,
            ),
          ),
          centerTitle: true,
          elevation: 0, // Remove the app bar shadow
          backgroundColor: Colors.black, // Set the background color
        ),
      ),
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // SizedBox(height: sizeHeight * 0.2),
            CustomBoldText(
                text: 'Create Account',
                fontSize: sizeHeight * 0.05,
                textColor: AppConstantsColors.brightWhiteColor,
              ),

            Stack(
              children: [
                GestureDetector(
                  onTap: _pickProfileImage,
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child:
                          _profileImage != null
                              ? Image.file(
                            _profileImage!,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          )
                              : Image.asset(
                            'assets/images/profile.png',
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                      ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
                    ),
                    child:  ClipOval(
                      child: Container(
                        color: Colors.grey,
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // LoginTextFieldWidget(controller: _nameController, hintText: 'Name'),
            LoginTextFieldWidget(
              controller: _emailController,
              hintText: 'Email',
              errorText : _isNotValid ? "Enter Email Field" : null,
            ),
            LoginTextFieldWidget(controller: _numberController, hintText: 'PhoneNumber', keyboardType: TextInputType.number,
              errorText : _isNotValid ? "Enter Number Field" : null,
            ),
            PasswordTextField(controller: _passWordController, hintText: 'Password',
              errorText:  _isNotValid ? "Enter Password Field" : null,
            ),


            CustomButton(
              text: 'SIGN UP',
              onPressed: ()=> {
                registerUser(),
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
                    text: 'Already have an account? ',
                  textColor: AppConstantsColors.whiteColor,
                ),
                ClickableText(
                  text : 'Sign In',
                  textColor : AppConstantsColors.raisedButtonColor,
                  fontSize : 14,
                  onPressed: () {
                    Navigator
                        .of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginPage()));
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
