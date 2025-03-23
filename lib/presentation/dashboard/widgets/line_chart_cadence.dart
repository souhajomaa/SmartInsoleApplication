import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartinsole/presentation/dashboard/widgets/custom_card_widget.dart';
import '../../../business_logic/cubit/api_sheet_cadence/api_sheet_cadence_cubit.dart';
import '../../../business_logic/cubit/api_sheet_cadence/api_sheet_cadence_state.dart';

class LineChartCadence extends StatefulWidget {
  const LineChartCadence({Key? key}) : super(key: key);

  @override
  State<LineChartCadence> createState() => _LineChartCadenceState();
}

class _LineChartCadenceState extends State<LineChartCadence> {
  @override
  void initState() {
    super.initState();
    context.read<ApiCadenceCubit>().getCadenceJson();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Cadence graph",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          AspectRatio(
            aspectRatio: 16 / 6,
            child: BlocConsumer<ApiCadenceCubit, ApiSheetCadenceState>(
              listener: (context, state) {
                if (state is JsonCadenceError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${state.message}')),
                  );
                }
              },
              builder: (context, state) {
                if (state is JsonCadenceLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is JsonCadenceLoaded) {
                  List<double> cadenceValues = [];
                  List<String> timeLabels = state.time;

                  for (var item in state.cadenceData) {
                    try {
                      double cadenceValue = item['Cadence'];
                      cadenceValues.add(
                          cadenceValue / 200.0); // Normalize values for graph
                    } catch (e) {
                      // Skip invalid entries
                    }
                  }

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: LineGraph(
                      features: [
                        Feature(
                          title: "Cadence data graph",
                          color: Colors.blue,
                          data: cadenceValues,
                        ),
                      ],
                      size: Size(cadenceValues.length * 70.0, 400),
                      labelX: timeLabels.map((time) {
                        List<String> parts = time.split(':');
                        return '${parts[0]}:${parts[1]}'; // Display only hours and minutes
                      }).toList(),
                      labelY: ['0', '50', '100', '150', '200'],
                      graphColor: Colors.blue,
                      graphOpacity: 0.2,
                    ),
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
