import 'package:expense_tracker/constants/app_constants_colors.dart';
import 'package:flutter/material.dart';

class LoginTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? errorText;
  final bool obscureText;
  final InputDecoration decoration;
  final TextInputType keyboardType;

  LoginTextFieldWidget({
    required this.controller,
    required this.hintText,
     this.errorText = "",
    this.obscureText = false,
    this.decoration = const InputDecoration(),
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppConstantsColors.transparent,
      child: TextField(
        keyboardType: keyboardType,
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
          color: AppConstantsColors.grey
        ),
        decoration: InputDecoration(
          labelText: hintText,
          errorText: errorText,
          labelStyle: const TextStyle(
            color: AppConstantsColors.brightWhiteColor
            ,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppConstantsColors.brightWhiteColor,
          ),
          filled: true,
          fillColor: AppConstantsColors.transparent,
          contentPadding: const EdgeInsets.all(16.0),
          border: OutlineInputBorder(

            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: AppConstantsColors.grey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: AppConstantsColors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: AppConstantsColors.grey),
          ),
        ),
      ),
    );
  }
}
