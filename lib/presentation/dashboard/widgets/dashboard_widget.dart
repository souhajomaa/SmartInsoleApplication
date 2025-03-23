import 'package:flutter/material.dart';
import 'package:smartinsole/presentation/dashboard/util/responsive.dart';
import 'package:smartinsole/presentation/dashboard/widgets/activity_details_card.dart';
//import 'package:smartinsole/presentation/dashboard/widgets/activityboutton.dart';
import 'package:smartinsole/presentation/dashboard/widgets/current_data.dart';
import 'package:smartinsole/presentation/dashboard/widgets/current_data_fsr.dart';
import 'package:smartinsole/presentation/dashboard/widgets/data_fsr.dart';
import 'package:smartinsole/presentation/dashboard/widgets/footLefypressure.dart';
import 'package:smartinsole/presentation/dashboard/widgets/footRightpressure.dart';
import 'package:smartinsole/presentation/dashboard/widgets/fsrbutton.dart';
import 'package:smartinsole/presentation/dashboard/widgets/header_widget.dart';
import 'package:smartinsole/presentation/dashboard/widgets/leftrightfoot.dart';
import 'package:smartinsole/presentation/dashboard/widgets/chatbot.dart';

class DashboardWidget extends StatefulWidget {
  final String email;

  const DashboardWidget({Key? key, required this.email}) : super(key: key);

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(height: 18),
            HeaderWidget(email: widget.email), // Passez l'email ici
            const SizedBox(height: 18),
            const CurrentData(),
            const SizedBox(height: 18),
            const ActivityDetailsCard(),
            const SizedBox(height: 18),

            const CurrentDataFsr(),
            const SizedBox(height: 18),
            const LeftRightFoot(),
            const SizedBox(height: 10),

            // Column to center the Row with the insoles
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InsoleLeftGrid(),
                    ),
                    SizedBox(width: 35),
                    Expanded(
                      child: InsoleGrid(),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            const FsrButton(),
            const SizedBox(height: 18),
            const DataFsr(),

            const SizedBox(height: 18),
            if (Responsive.isTablet(context)) const ChatbotWidget(),
          ],
        ),
      ),
    );
  }
}
