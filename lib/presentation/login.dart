import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Ajouté pour utiliser BlocProvider
import 'package:smartinsole/components/square_tile.dart';
import 'package:smartinsole/components/textfield.dart';
import 'package:smartinsole/components/button.dart';
import 'package:smartinsole/services/auth_servicegoogle.dart';

import '../business_logic/cubit/cubit header trainer/header_trainer_cubit.dart';
import 'dashboard/widgets/dashboard_widget.dart';

class Login extends StatefulWidget {
  final Function()? onTap;
  const Login({Key? key, required this.onTap}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final username = TextEditingController();
  final password = TextEditingController();
  bool _isHovered = false;
  late Color myColor;
  bool isObscure = true;

  void singUser() async {
    // Show loading circle
    showDialog(
      context: context,
      builder: (context) {
        BuildContext dialogContext = context;

        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(dialogContext).pop();
        });

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // Sign in
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: username.text,
        password: password.text,
      );

      final email = username.text;
      await BlocProvider.of<HeaderTrainerCubit>(context).getUsername(email);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              DashboardWidget(email: userCredential.user!.email!),
        ),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.red,
          title: Text(
            'Incorrect email or password',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;

    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        image: DecorationImage(
          image: AssetImage("assets/images/semelleconnectee.jpg"),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(myColor.withOpacity(0.5), BlendMode.dstATop),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const Icon(
                Icons.sports_soccer,
                size: 100,
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome back to Smart Insole app! ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Textfield(
                isObscure: false,
                suffixIcon: Icon(Icons.email),
                controller: username,
                hintText: 'Enter your E-mail',
              ),
              const SizedBox(height: 15),
              Textfield(
                isObscure: isObscure,
                suffixIcon: IconButton(
                    icon: isObscure
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    }),
                controller: password,
                hintText: 'Enter your password',
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  // Action pour récupérer le mot de passe oublié
                },
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: Color.fromARGB(255, 7, 62, 107),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Button(
                text: 'Sign in',
                onTap: singUser,
              ),
              const SizedBox(height: 20),
              const Text('Or continue with'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(
                    onTap: () => signInWithGoogle(context),
                    imagePath: 'assets/images/google.png',
                  ),
                  const SizedBox(width: 25),
                  SquareTile(
                    onTap: () {},
                    imagePath: 'assets/images/apple.jpg',
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: MouseRegion(
                      onEnter: (_) => setState(() => _isHovered = true),
                      onExit: (_) => setState(() => _isHovered = false),
                      child: Text(
                        'Register now',
                        style: TextStyle(
                          color: _isHovered
                              ? Colors.purple
                              : Color.fromARGB(255, 7, 62, 107),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
