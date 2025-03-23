import 'package:flutter/material.dart';
import 'package:smartinsole/presentation/dashboard/widgets/line_chart_cadence.dart';
import 'package:smartinsole/presentation/dashboard/widgets/line_chart_distance.dart';
import 'package:smartinsole/presentation/dashboard/widgets/line_chart_stridelength.dart';

class ActivityGraphs extends StatefulWidget {
  const ActivityGraphs({super.key});

  @override
  State<ActivityGraphs> createState() => _ActivityGraphsState();
}

class _ActivityGraphsState extends State<ActivityGraphs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Graphs'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: ListView(
            children: const [
              LineChartCadence(),
              SizedBox(height: 29),
              LineChartDistance(),
              SizedBox(height: 29),
              LineChartStrideLength(),
            ],
          ),
        ),
      ),
    );
  }
}
