import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/cubit/cubit foot pressure/footpressure_cubit.dart';
import '../../../business_logic/cubit/cubit foot pressure/footpressure_state.dart';
import 'custom_card_widget.dart';

class DataFsr extends StatefulWidget {
  const DataFsr({super.key});

  @override
  State<DataFsr> createState() => _DataFsrState();
}

class _DataFsrState extends State<DataFsr> {
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<InsoleCubit, InsoleState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is InsoleInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is InsoleLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Right foot force values:',
                    style: TextStyle(color: Colors.lightGreen, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  DataTable(
                    columns: const [
                      DataColumn(
                        label: Text(
                          'Number : ',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Value (N)',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                    rows: List.generate(state.fsrValues.length, (index) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Text(
                              ' ${index + 1}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          DataCell(
                            Text(
                              '${state.fsrValues[index]}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text(
                  'Failed to load FSR values',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
