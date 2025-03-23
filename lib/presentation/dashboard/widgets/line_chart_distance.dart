import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartinsole/business_logic/cubit/api_sheet_distance/api_sheet_distance_state.dart';
import 'package:smartinsole/presentation/dashboard/widgets/custom_card_widget.dart';
import '../../../business_logic/cubit/api_sheet_distance/api_sheet_distance_cubit.dart';

class LineChartDistance extends StatefulWidget {
  const LineChartDistance({Key? key}) : super(key: key);

  @override
  State<LineChartDistance> createState() => _LineChartDistanceState();
}

class _LineChartDistanceState extends State<LineChartDistance> {
  @override
  void initState() {
    super.initState();
    context.read<ApiDistanceCubit>().getDistanceJson();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Distance graph",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          AspectRatio(
            aspectRatio: 16 / 6,
            child: BlocConsumer<ApiDistanceCubit, ApiSheetDistanceState>(
              listener: (context, state) {
                if (state is JsonDistanceError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${state.message}')),
                  );
                }
              },
              builder: (context, state) {
                if (state is JsonDistanceLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is JsonDistanceLoaded) {
                  List<double> distanceValues = [];
                  List<String> timeLabels = state.time;

                  for (var item in state.distanceData) {
                    try {
                      double distanceValue = item['Distance'];
                      distanceValues.add(
                          distanceValue / 200.0); // Normalize values for graph
                    } catch (e) {
                      // Skip invalid entries
                    }
                  }

                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        child: LineGraph(
                          features: [
                            Feature(
                              title: "Distance data graph",
                              color: Colors.green,
                              data: distanceValues,
                            ),
                          ],
                          size: Size(distanceValues.length * 70.0,
                              constraints.maxHeight),
                          labelX: timeLabels.map((time) {
                            List<String> parts = time.split(':');
                            return '${parts[0]}:${parts[1]}'; // Display only hours and minutes
                          }).toList(),
                          labelY: const ['500', '1000', '1500', '2000', '2500'],
                          graphColor: Colors.green,
                          graphOpacity: 0.2,
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No Data Available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
