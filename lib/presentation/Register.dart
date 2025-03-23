import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Ajouté pour utiliser BlocProvider
import 'package:smartinsole/components/square_tile.dart';
import 'package:smartinsole/components/textfield.dart';
import 'package:smartinsole/components/button.dart';
import 'package:smartinsole/database/firebase/register_firebase.dart';
import 'package:smartinsole/services/auth_servicegoogle.dart';

import '../business_logic/cubit/cubit header trainer/header_trainer_cubit.dart';
import 'dashboard/widgets/dashboard_widget.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool _isHovered = false;
  bool isObscure = true;
  late Color myColor;

  final RegisterManager _registerManager = RegisterManager();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void singUserUp() async {
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

    if (passwordController.text.length < 5) {
      showErrorMessage("Password must be at least 5 characters long");
      return;
    }

    try {
      if (passwordController.text == confirmPasswordController.text) {
        await _registerManager.signUpUser(
          emailController.text,
          passwordController.text,
        );

        await _registerManager.addUserDetails(
          usernameController.text.trim(),
          emailController.text.trim(),
        );
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

        // Récupérer le nom d'utilisateur après une inscription réussie
        final email = emailController.text.trim();
        await BlocProvider.of<HeaderTrainerCubit>(context).getUsername(email);

        // Naviguer vers la page principale
       Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardWidget(email: userCredential.user!.email!),
        ),
      );
      } else {
        Navigator.pop(context);
        showErrorMessage("Password is not confirmed");
      }
    } catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.toString());
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.red,
          title: const Text(
            "Something's wrong. Please try again",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          content: Text(
            message,
            style: const TextStyle(color: Colors.white),
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
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Back icon
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  //logo
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      Icon(
                        Icons.sports_soccer,
                        size: 100,
                      ),
                    ],
                  ),

                  //text
                  const SizedBox(height: 30),
                  const Text(
                    'Create a new account! ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  // usernameController
                  Textfield(
                    isObscure: false,
                    suffixIcon: Icon(Icons.person),
                    controller: usernameController,
                    hintText: ('username'),
                  ),
                  const SizedBox(height: 10),

                  //email textfield
                  Textfield(
                    isObscure: false,
                    suffixIcon: Icon(Icons.email),
                    controller: emailController,
                    hintText: ('Email'),
                  ),
                  const SizedBox(height: 10),

                  //password textfield
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
                    controller: passwordController,
                    hintText: 'password',
                  ),
                  const SizedBox(height: 10),

                  //confirm password textfield
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
                    controller: confirmPasswordController,
                    hintText: 'Confirm password',
                  ),
                  const SizedBox(height: 10),

                  //sign up button
                  Button(
                    text: "Sign Up",
                    onTap: singUserUp,
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

                  //already have an account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: MouseRegion(
                          onEnter: (_) => setState(() => _isHovered = true),
                          onExit: (_) => setState(() => _isHovered = false),
                          child: Text(
                            'Login now',
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
        ),
      ),
    );
  }
}
