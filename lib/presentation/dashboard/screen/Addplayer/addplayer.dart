import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smartinsole/presentation/dashboard/screen/Addplayer/Textfieldplayer.dart';
import 'package:smartinsole/database/databaseplayers.dart';
import 'package:smartinsole/presentation/dashboard/screen/Addplayer/playerdata.dart';
import 'package:smartinsole/presentation/dashboard/screen/Addplayer/playerprofile.dart';

class AddPlayerPage extends StatefulWidget {
  const AddPlayerPage({Key? key}) : super(key: key);

  @override
  State<AddPlayerPage> createState() => _AddPlayerPageState();
}

class _AddPlayerPageState extends State<AddPlayerPage> {
  final nameAndSurnameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final weightController = TextEditingController();
  final sizeController = TextEditingController();
  final strongfootController = TextEditingController();

  Stream? playerStream;

  getOnTheLoad() async {
    playerStream = await DatabasePlayers().getPlayersDetails();
    setState(() {});
  }

  @override
  void initState() {
    getOnTheLoad();
    super.initState();
  }

  Widget allPlayersDetails() {
    return StreamBuilder(
        stream: playerStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot doc = snapshot.data.docs[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Name & Surname: ${doc['Name & Surname']}",
                                    style: const TextStyle(
                                        color: Colors.cyan,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      nameAndSurnameController.text = doc["Name & Surname"];
                                      emailController.text = doc["E-mail"];
                                      ageController.text = doc["Age"];
                                      weightController.text = doc["Weight"];
                                      sizeController.text = doc["Size"];
                                      strongfootController.text = doc["Strong foot"];
                                      editPlayersDetails(doc["Id"]);
                                    },
                                    child: const Icon(Icons.edit, color: Colors.green),
                                  ),
                                  const SizedBox(height: 5.0),
                                  GestureDetector(
                                    onTap: () async {
                                      await deletePlayerDetail(context, doc["Id"]);
                                    },
                                    child: const Icon(Icons.delete, color: Colors.red),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlayerProfilePage(playerDoc: doc),
                                    ),
                                  );
                                },
                                child: const Text('See Profile'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : const Center(child: CircularProgressIndicator());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const PlayerData()));
        },
        child: const Icon(Icons.add),
      ),
      backgroundColor: Colors.white,
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
              'List',
              style: TextStyle(
                color: Colors.lightGreen,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: allPlayersDetails()),
          ],
        ),
      ),
    );
  }

  Future editPlayersDetails(String id) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Row(
                    children: [
                      Icon(Icons.cancel),
                      SizedBox(width: 100.0),
                      Text(
                        'Edit',
                        style: TextStyle(
                          color: Colors.cyan,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Details',
                        style: TextStyle(
                          color: Colors.lightGreen,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                InputField(
                    label: "Name & Surname",
                    controller: nameAndSurnameController,
                    hintText: "Please enter your full name and surname here"),
                const SizedBox(height: 20.0),
                InputField(
                    label: "E-mail",
                    controller: emailController,
                    hintText: "Please enter your E-mail here "),
                const SizedBox(height: 20.0),
                InputField(
                    label: "Age",
                    controller: ageController,
                    hintText: "Please enter your age here"),
                const SizedBox(height: 20.0),
                InputField(
                    label: "Weight",
                    controller: weightController,
                    hintText: "Please enter your weight here"),
                const SizedBox(height: 20.0),
                InputField(
                    label: "Size",
                    controller: sizeController,
                    hintText: "Please enter your size here"),
                const SizedBox(height: 20.0),
                InputField(
                    label: "Strong foot",
                    controller: strongfootController,
                    hintText: "Please enter your strong foot here"),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    Map<String, dynamic> updateInfo = {
                      "Name & Surname": nameAndSurnameController.text,
                      "Id": id,
                      "Weight": weightController.text,
                      "E-mail": emailController.text,
                      "Age": ageController.text,
                      "Size": sizeController.text,
                      "Strong foot": strongfootController.text,
                    };
                    await DatabasePlayers()
                        .updatePlayerDetail(id, updateInfo)
                        .then((value) {
                      Navigator.pop(context);
                      getOnTheLoad();
                    });
                  },
                  child: const Text("Update"),
                ),
              ],
            ),
          ),
        ),
      );

  Future deletePlayerDetail(BuildContext context, String id) async {
    try {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Confirm Deletion"),
          content: const Text("Are you sure you want to delete this player?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context); // Close confirmation dialog
                await FirebaseFirestore.instance.collection("players").doc(id).update({
                  'E-mail': FieldValue.delete(),
                  'Age': FieldValue.delete(),
                  'Weight': FieldValue.delete(),
                  'Size': FieldValue.delete(),
                  'Strong foot': FieldValue.delete(),
                });
              },
              child: const Text("Delete"),
            ),
          ],
        ),
      );
    } catch (error) {
      print("Error deleting player: $error");
    }
  }
}
