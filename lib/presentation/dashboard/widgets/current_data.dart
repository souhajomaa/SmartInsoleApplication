import 'package:flutter/material.dart';
import 'package:smartinsole/presentation/dashboard/widgets/custom_card_widget.dart';

class CurrentData extends StatefulWidget {
  const CurrentData({super.key});

  @override
  State<CurrentData> createState() => _CurrentDataState();
}

class _CurrentDataState extends State<CurrentData> {
  @override
  Widget build(BuildContext context) {
    return const CustomCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'The player’s performance data will be displayed below.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w200,
            ),
          ),
        ],
      ),
    );
  }
}
