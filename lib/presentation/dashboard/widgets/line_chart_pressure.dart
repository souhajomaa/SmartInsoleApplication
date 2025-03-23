import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartinsole/presentation/dashboard/widgets/custom_card_widget.dart';

import '../../../business_logic/cubit/api sheet pressure/api_sheet_brut_cubit.dart';
import 'fsr_graph.dart';

class LineChartPressure extends StatefulWidget {
  const LineChartPressure({Key? key}) : super(key: key);

  @override
  State<LineChartPressure> createState() => _LineChartPressureState();
}

class _LineChartPressureState extends State<LineChartPressure> {
  @override
  void initState() {
    super.initState();
    context.read<ApiSheetBrutCubit>().getFsrValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Force',
              style: TextStyle(
                color: Colors.cyan,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Text(
              'Graphs',
              style: TextStyle(
                color: Colors.lightGreen,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: BlocConsumer<ApiSheetBrutCubit, ApiSheetBrutState>(
        listener: (context, state) {
          if (state is JsonErrorBrut) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          if (state is JsonLoadingBrut) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is JsonLoadedBrut) {
            List<Feature> features1 = [
              Feature(
                title: "Force 1",
                color: Colors.green,
                data: state.fsrValues
                    .map((e) => e["FSR1"] as num)
                    .toList()
                    .map((v) => v / 1000)
                    .toList(),
              ),
              Feature(
                title: "Force 2",
                color: Colors.red,
                data: state.fsrValues
                    .map((e) => e["FSR2"] as num)
                    .toList()
                    .map((v) => v / 1000)
                    .toList(),
              ),
              Feature(
                title: "Force 3",
                color: Colors.blue,
                data: state.fsrValues
                    .map((e) => e["FSR3"] as num)
                    .toList()
                    .map((v) => v / 1000)
                    .toList(),
              ),
            ];

            List<Feature> features2 = [
              Feature(
                title: "Force 4",
                color: Colors.yellow,
                data: state.fsrValues
                    .map((e) => e["FSR4"] as num)
                    .toList()
                    .map((v) => v / 1000)
                    .toList(),
              ),
              Feature(
                title: "Force 5",
                color: Colors.purple,
                data: state.fsrValues
                    .map((e) => e["FSR5"] as num)
                    .toList()
                    .map((v) => v / 1000)
                    .toList(),
              ),
            ];

            List<Feature> features3 = [
              Feature(
                title: "Force 6",
                color: Colors.orange,
                data: state.fsrValues
                    .map((e) => e["FSR6"] as num)
                    .toList()
                    .map((v) => v / 1000)
                    .toList(),
              ),
              Feature(
                title: "Force 7",
                color: Colors.pink,
                data: state.fsrValues
                    .map((e) => e["FSR7"] as num)
                    .toList()
                    .map((v) => v / 1000)
                    .toList(),
              ),
              Feature(
                title: "Force 8",
                color: Colors.cyan,
                data: state.fsrValues
                    .map((e) => e["FSR8"] as num)
                    .toList()
                    .map((v) => v / 1000)
                    .toList(),
              ),
            ];

            List<String> labelX = List.from(state.time.reversed).map((time) {
              List<String> parts = time.split(':');
              return '${parts[0]}:${parts[1]}'; // Afficher uniquement heure et minute
            }).toList();

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Right Foot',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  CustomCard(
                    child: FSRGraph(
                      title: "Force graphs in the forefoot part",
                      features: features1,
                      labelX: labelX,
                      length: state.fsrValues.length,
                    ),
                  ),
                  CustomCard(
                    child: FSRGraph(
                      title: "Force graphs in the mid-foot part",
                      features: features2,
                      labelX: labelX,
                      length: state.fsrValues.length,
                    ),
                  ),
                  CustomCard(
                    child: FSRGraph(
                      title: "Force graphs in the hindfoot part",
                      features: features3,
                      labelX: labelX,
                      length: state.fsrValues.length,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
}
