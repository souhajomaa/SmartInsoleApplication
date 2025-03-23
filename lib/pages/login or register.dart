import 'package:flutter/material.dart';
import 'package:smartinsole/presentation/Register.dart';
import 'package:smartinsole/presentation/login.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

//toggle between login and register//
  void toggle() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return Login(
        onTap: toggle,
      );
    } else {
      return RegisterPage(onTap: toggle);
    }
  }
}
