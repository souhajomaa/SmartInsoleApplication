import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/cubit/api sheet analysed/api_sheet_cubit.dart';

class HistoryTable extends StatefulWidget {
  const HistoryTable({Key? key}) : super(key: key);

  @override
  State<HistoryTable> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryTable> {
  @override
  void initState() {
    super.initState();

    final apiCubit = ApiCubit.get(context);
    apiCubit.getJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'History',
              style: TextStyle(
                color: Colors.cyan,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Text(
              'Player',
              style: TextStyle(
                color: Colors.lightGreen,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: BlocConsumer<ApiCubit, ApiState>(
                listener: (context, state) {
                  if (state is JsonError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${state.message}')),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is JsonLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is JsonLoaded) {
                    var filteredData = state.data.where((item) {
                      return item['Date'] != null &&
                          item['Time'] != null &&
                          item['Cadence'] != null &&
                          item['Steps'] != null &&
                          item['Distance'] != null &&
                          item['Stride Length'] != null;
                    }).toList();

                    List<Map<String, dynamic>> uniqueData = [];
                    for (var item in filteredData) {
                      if (!uniqueData.any(
                          (uniqueItem) => areRowsEqual(uniqueItem, item))) {
                        uniqueData.add(item);
                      }
                    }

                    uniqueData = uniqueData.reversed.toList();

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Date')),
                          DataColumn(label: Text('Time')),
                          DataColumn(label: Text('Cadence')),
                          DataColumn(label: Text('Steps')),
                          DataColumn(label: Text('Distance')),
                          DataColumn(label: Text('Stride Length')),
                        ],
                        rows: uniqueData.map<DataRow>((item) {
                          return DataRow(
                            cells: [
                              DataCell(Text(item['Date'].toString())),
                              DataCell(Text(item['Time'].toString())),
                              DataCell(Text(item['Cadence'].toString())),
                              DataCell(Text(item['Steps'].toString())),
                              DataCell(Text(item['Distance'].toString())),
                              DataCell(Text(item['Stride Length'].toString())),
                            ],
                          );
                        }).toList(),
                      ),
                    );
                  } else if (state is JsonError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool areRowsEqual(Map<String, dynamic> row1, Map<String, dynamic> row2) {
    return row1['Date'] == row2['Date'] &&
        row1['Cadence'] == row2['Cadence'] &&
        row1['Steps'] == row2['Steps'] &&
        row1['Distance'] == row2['Distance'] &&
        row1['Stride Length'] == row2['Stride Length'];
  }
}
