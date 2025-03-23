import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileTrainerPage extends StatefulWidget {
  ProfileTrainerPage({Key? key}) : super(key: key);

  @override
  State<ProfileTrainerPage> createState() => _ProfileTrainerPageState();
}

class _ProfileTrainerPageState extends State<ProfileTrainerPage> {
  //current logged in user
  User? currentUser = FirebaseAuth.instance.currentUser;

  //future to fetch user details
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    if (currentUser != null) {
      print("Fetching details for user: ${currentUser!.email}");
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection("users")
              .where("email", isEqualTo: currentUser!.email)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first;
      } else {
        throw Exception("No user found with the given email.");
      }
    } else {
      throw Exception("No user is currently logged in.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Profile',
              style: TextStyle(
                color: Colors.cyan,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Text(
              'Trainer',
              style: TextStyle(
                color: Colors.lightGreen,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            var userData = snapshot.data!.data();
            if (userData == null) {
              print("No data found for user: ${currentUser!.email}");
              return Text("No data available");
            }
            print("Data found: ${userData.toString()}");
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    padding: const EdgeInsets.all(25.0),
                    child: Icon(Icons.person),
                  ),
                  Text(userData['email'] ?? 'No email'),
                  Text(userData['username'] ?? 'No username'),
                  SizedBox(height: 20), // Spacing between sections
                  Container(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.edit),
                          title: Text('Edit Profile'),
                          onTap: () {
                            // Handle edit profile action
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.settings),
                          title: Text('Settings'),
                          onTap: () {
                            // Handle settings action
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.light_mode),
                          title: Text('Change Mode'),
                          onTap: () {
                            // Handle change mode action
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            print("No data found for user: ${currentUser!.email}");
            return Text("No data available");
          }
        },
      ),
    );
  }
}
