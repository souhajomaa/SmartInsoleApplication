import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartinsole/business_logic/cubit/api_sheet_stridelength/api_sheet_stridelength_cubit.dart';
import 'package:smartinsole/business_logic/cubit/api_sheet_stridelength/api_sheet_stridelength_state.dart';
import 'package:smartinsole/presentation/dashboard/widgets/custom_card_widget.dart';

class LineChartStrideLength extends StatefulWidget {
  const LineChartStrideLength({Key? key}) : super(key: key);

  @override
  State<LineChartStrideLength> createState() => _LineChartStrideLengthState();
}

class _LineChartStrideLengthState extends State<LineChartStrideLength> {
  @override
  void initState() {
    super.initState();
    context.read<ApiStrideLengthCubit>().getStrideLengthJson();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Stride Length graph",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          AspectRatio(
            aspectRatio: 16 / 6,
            child: BlocConsumer<ApiStrideLengthCubit, ApiSheetStrideLengthState>(
              listener: (context, state) {
                if (state is JsonStrideLengthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${state.message}')),
                  );
                }
              },
              builder: (context, state) {
                if (state is JsonStrideLengthLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is JsonStrideLengthLoaded) {
                  List<double> strideLengthDataValues = [];
                  List<String> timeLabels = state.time;

                  for (var item in state.strideLengthData) {
                    try {
                      double strideLengthDataValue = item['Stride Length'];
                      strideLengthDataValues.add(
                          strideLengthDataValue / 200.0); // Normalize values for graph
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
                              title: "Stride Length Data",
                              color: Colors.red,
                              data: strideLengthDataValues,
                            ),
                          ],
                          size: Size(strideLengthDataValues.length * 70.0, constraints.maxHeight),
                          labelX: timeLabels.map((time) {
                            List<String> parts = time.split(':');
                            return '${parts[0]}:${parts[1]}'; // Display only hours and minutes
                          }).toList(),
                          labelY: const ['0.4', '0.6', '0.8', '1.0'],
                          graphColor: Colors.red,
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
