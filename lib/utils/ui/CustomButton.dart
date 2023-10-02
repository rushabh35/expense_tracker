import 'package:expense_tracker/constants/app_constants_colors.dart';
import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  late String text;
  late Function onPressed;
  late double width;
  late double height;
  CustomButton({super.key, required this.text, required this.onPressed,  this.width = 500,  this.height = 50});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return  SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(

        onPressed : () => onPressed(),
        style: ElevatedButton.styleFrom(

          primary: AppConstantsColors.raisedButtonColor, // Button color
          onPrimary: Colors.black, // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Adjust the radius as needed
          ),
        ),
        child: Text(text),

      ),
    );
  }
  
}