import 'package:flutter/material.dart';
import 'package:smartinsole/presentation/dashboard/widgets/custom_card_widget.dart';

class ActivityButton extends StatefulWidget {
  const ActivityButton({super.key});

  @override
  State<ActivityButton> createState() => _ActivityButtonState();
}

class _ActivityButtonState extends State<ActivityButton> {
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Click the button to display the player’s performance graphs',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w200,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
             onPressed: () {
              Navigator.pushNamed(context, '/activity_graphs');
            },
            child: const Text('Show graphs'),
          ),
        ],
      ),
    );
  }
}
