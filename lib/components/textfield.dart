import 'package:flutter/material.dart';

class Textfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? suffixIcon;
  final bool isObscure;

  const Textfield({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.suffixIcon,
    required this.isObscure,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70.0),
      child: TextField(
          obscureText:isObscure,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.only(),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          fillColor: Colors.white,
        
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
