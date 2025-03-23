import 'package:flutter/material.dart';
import 'package:smartinsole/presentation/dashboard/widgets/custom_card_widget.dart';
import 'package:smartinsole/presentation/dashboard/widgets/line_chart_pressure.dart';


class FsrButton extends StatefulWidget {
  const FsrButton({Key? key}) : super(key: key);

  @override
  State<FsrButton> createState() => _FsrButtonState();
}

class _FsrButtonState extends State<FsrButton> {
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Click the button to display the force graphs of foots',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w200,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
             onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LineChartPressure()), // Naviguez vers LineChartPressure
              );
            },
            child: const Text('Show graphs'),
          ),
        ],
      ),
    );
  }
}

