import 'package:flutter/material.dart';

import 'package:smartinsole/presentation/dashboard/screen/Addplayer/addplayer.dart';
import 'package:smartinsole/presentation/dashboard/screen/Historyplayer/historytable.dart';
import 'package:smartinsole/presentation/dashboard/screen/profiletrainer.dart';
import 'package:smartinsole/presentation/dashboard/widgets/activity_details_card.dart';
import 'package:smartinsole/presentation/dashboard/widgets/activitygraphs.dart';
import 'package:smartinsole/presentation/dashboard/widgets/line_chart_pressure.dart';
import 'package:smartinsole/presentation/login.dart';

import '../presentation/Register.dart';

Map<String, WidgetBuilder> getRoutes() {
  return {
    '/profile': (context) => ProfileTrainerPage(),
    '/history': (context) => const HistoryTable(),
    '/add player': (context) => const AddPlayerPage(),
    '/activity': (context) => const ActivityDetailsCard(),
    '/login': (context) => const Login(onTap: null),
    '/register': (context) => const RegisterPage(onTap: null),
    '/activity_graphs': (context) => const ActivityGraphs(),
    '/line_chart_pressure': (context) =>
        const LineChartPressure(), // Ajoutez la nouvelle route
  };
}
