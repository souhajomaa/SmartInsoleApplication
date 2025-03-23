import 'package:flutter/material.dart';
import 'package:smartinsole/const/const.dart';
import 'package:smartinsole/presentation/dashboard/data/side_menu_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart'; // Ajouter l'importation
import 'package:smartinsole/presentation/dashboard/screen/Addplayer/addplayer.dart';
import 'package:smartinsole/presentation/dashboard/screen/Historyplayer/historytable.dart';
import 'package:smartinsole/presentation/dashboard/screen/profiletrainer.dart';

class SideMenuWidget extends StatefulWidget {
  const SideMenuWidget({Key? key}) : super(key: key);

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  int selectedIndex = 0;
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final data = SideMenuData();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: cardBackgroundColor,
      child: ListView.builder(
        itemCount: data.menu.length,
        itemBuilder: (context, index) => buildMenuEntry(data, index),
      ),
    );
  }

  Widget buildMenuEntry(SideMenuData data, int index) {
    final isSelected = selectedIndex == index;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(6.0),
        ),
        color: isSelected ? selectionColor : Colors.transparent,
      ),
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            isHovered = true;
            isSelected ? selectionColor : Colors.transparent;
          });
        },
        onExit: (_) {
          setState(() {
            isHovered = false;
          });
        },
        child: InkWell(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });

            if (data.menu[index].title == 'SignOut') {
              MessageAlert(context);
            } else if (data.menu[index].title == 'History') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HistoryTable()));
            } else if (data.menu[index].title == 'Add player') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddPlayerPage()));
            } else if (data.menu[index].title == 'Profile') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  ProfileTrainerPage()));
            }
          },
          child: Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                child: Icon(
                  data.menu[index].icon,
                  color: isSelected ? Colors.black : Colors.grey,
                ),
              ),
              Text(
                data.menu[index].title,
                style: TextStyle(
                  fontSize: 16,
                  color: isSelected ? Colors.black : Colors.grey,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void MessageAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Exit Confirmation'),
          content: const Text('Are you sure you want to exit?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                signUserOut();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}