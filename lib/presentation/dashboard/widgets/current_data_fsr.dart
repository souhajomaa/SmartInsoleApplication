import 'package:flutter/material.dart';
import 'package:smartinsole/presentation/dashboard/widgets/custom_card_widget.dart';

class CurrentDataFsr extends StatefulWidget {
  const CurrentDataFsr({super.key});

  @override
  State<CurrentDataFsr> createState() => _CurrentDataFsrState();
}

class _CurrentDataFsrState extends State<CurrentDataFsr> {
  @override
  Widget build(BuildContext context) {
    return const CustomCard(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'The player’s foots will be displayed below.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w200,
              ),
            ),
            SizedBox(width: 25), 
            Text(
              'red color ',
              style: TextStyle(
                color: Colors.red,
                fontSize: 14,
                fontWeight: FontWeight.w200,
              ),
            ),
            Text(
              'means high force of the foot part on the ground',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w200,
              ),
            ),
            SizedBox(width: 25), // Correction: Utiliser width au lieu de height
            Text(
              'yellow color ',
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 14,
                fontWeight: FontWeight.w200,
              ),
            ),
            Text(
              'means medium force of the foot part on the ground',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w200,
              ),
            ),
            SizedBox(width: 25), // Correction: Utiliser width au lieu de height
            Text(
              'blue color ',
              style: TextStyle(
                color: Color.fromARGB(255, 108, 202, 221),
                fontSize: 14,
                fontWeight: FontWeight.w200,
              ),
            ),
            Text(
              'means low force of the foot part on the ground',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
