import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';
import 'package:smartinsole/presentation/dashboard/screen/Addplayer/Textfieldplayer.dart';
import 'package:smartinsole/database/databaseplayers.dart';
import 'package:smartinsole/presentation/dashboard/util/responsive.dart';

class PlayerData extends StatefulWidget {
  const PlayerData({Key? key}) : super(key: key);

  @override
  State<PlayerData> createState() => _PlayerDataState();
}

class _PlayerDataState extends State<PlayerData> {
  final TextEditingController nameAndSurnameController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController strongfootController = TextEditingController();

  @override
  void dispose() {
    nameAndSurnameController.dispose();
    emailController.dispose();
    ageController.dispose();
    weightController.dispose();
    sizeController.dispose();
    strongfootController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Player',
              style: TextStyle(
                color: Colors.cyan,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Text(
              'Form',
              style: TextStyle(
                color: Colors.lightGreen,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: isMobile ? 20.0 : 100.0,
            vertical: isMobile ? 30.0 : 50.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputField(
                label: "Name & Surname",
                controller: nameAndSurnameController,
                hintText: "Please enter your full name and surname here",
              ),
              InputField(
                label: "E-mail",
                controller: emailController,
                hintText: "Please enter your E-mail here ",
              ),
              InputField(
                label: "Age",
                controller: ageController,
                hintText: "Please enter your age here",
              ),
              InputField(
                label: "Weight",
                controller: weightController,
                hintText: "Please enter your weight here",
              ),
              InputField(
                label: "Size",
                controller: sizeController,
                hintText: "Please enter your size here",
              ),
              InputField(
                label: "Strong foot",
                controller: strongfootController,
                hintText: "Please enter your strong foot here",
              ),
              const SizedBox(height: 30.0),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    String nameSurname = nameAndSurnameController.text;
                    String email = emailController.text;
                    String age = ageController.text;
                    String weight = weightController.text;
                    String size = sizeController.text;
                    String strongfoot = strongfootController.text;

                    if (nameSurname.isEmpty ||
                        email.isEmpty ||
                        age.isEmpty ||
                        weight.isEmpty ||
                        size.isEmpty ||
                        strongfoot.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Please fill in all fields!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      return;
                    }

                    bool exists = await DatabasePlayers().checkDataExists(
                      nameSurname: nameSurname,
                      email: email,
                      age: age,
                      weight: weight,
                      size: size,
                      strongfoot: strongfoot,
                    );

                    if (exists) {
                      Fluttertoast.showToast(
                        msg: "Data already exists!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    } else {
                      String id = randomAlphaNumeric(20);
                      Map<String, dynamic> playerInfoMap = {
                        "Id": id,
                        "Name & Surname": nameSurname,
                        "E-mail": email,
                        "Age": age,
                        "Weight": weight,
                        "Size": size,
                        "Strong foot": strongfoot,
                      };
                      await DatabasePlayers().addPlayersDetails(
                        playerInfoMap,
                        id,
                      );

                      Fluttertoast.showToast(
                        msg: "The player was added successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );

                      setState(() {
                        nameAndSurnameController.clear();
                        emailController.clear();
                        ageController.clear();
                        weightController.clear();
                        sizeController.clear();
                        strongfootController.clear();
                      });
                    }
                  },
                  child: const Text(
                    "Add",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
