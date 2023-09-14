import 'package:flutter/material.dart';

class LoginTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final InputDecoration decoration;

  LoginTextFieldWidget({
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.decoration = const InputDecoration(),
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.grey,
          contentPadding: EdgeInsets.all(16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ), // Customize the prefix icon as needed
          // Add more customization to the decoration if desired
          // You can pass your custom decoration properties as needed
          // For example: `decoration: InputDecoration(labelText: 'Username')`
        ),
      ),
    );
  }
}
