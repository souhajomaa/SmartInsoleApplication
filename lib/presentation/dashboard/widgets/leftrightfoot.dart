import 'package:flutter/material.dart';
import 'package:smartinsole/presentation/dashboard/widgets/custom_card_widget.dart';


class LeftRightFoot extends StatefulWidget {
  const LeftRightFoot({Key? key}) : super(key: key);

  @override
  State<LeftRightFoot> createState() => _LeftRightFootState();
}

class _LeftRightFootState extends State<LeftRightFoot> {
  @override
  Widget build(BuildContext context) {
    return const CustomCard(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  'Left foot',
                  style: TextStyle(
                    color: Colors.lightGreen,
                    fontSize: 18,
                    fontWeight: FontWeight.w200,
                  ),
                ), // Ajout du texte "Left foot" pour InsoleLeftGrid()
              ],
            ),
            SizedBox(width: 100), // Espacement entre les deux semelles
            Column(
              children: [
                Text(
                  'Right foot',
                  style: TextStyle(
                    color: Colors.lightGreen,
                    fontSize: 18,
                    fontWeight: FontWeight.w200,
                  ),
                ), // Ajout du texte "Right foot" pour InsoleGrid()
        
              ],
            ),
          ],
        ),
      ),
    );
  }
}
