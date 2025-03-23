import 'package:flutter/material.dart';
import 'package:smartinsole/presentation/dashboard/util/responsive.dart';
import 'package:smartinsole/presentation/dashboard/widgets/dashboard_widget.dart';
import 'package:smartinsole/presentation/dashboard/widgets/side_menu_widget.dart';
import 'package:smartinsole/presentation/dashboard/widgets/chatbot.dart';

class HomePage extends StatefulWidget {
  final String email;

  const HomePage({Key? key, required this.email}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 53, 156, 108),
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidget(),
            )
          : null,
      endDrawer: Responsive.isMobile(context)
          ? SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: const ChatbotWidget(),
            )
          : null,
      body: SafeArea(
        child: Row(
          children: [
            if (isDesktop)
              const Expanded(
                flex: 2,
                child: SizedBox(
                  child: SideMenuWidget(),
                ),
              ),
            Expanded(
              flex: 7,
              child: DashboardWidget(email: widget.email),
            ),
            if (isDesktop)
              const Expanded(
                flex: 3,
                child: ChatbotWidget(),
              ),
          ],
        ),
      ),
    );
  }
}
