import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/cubit/api_sheet_summary/api_sheet_summary_cubit.dart';
import '../../../../business_logic/cubit/api_sheet_summary/api_sheet_summary_state.dart';

class SummaryDetails extends StatelessWidget {
  const SummaryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Summary',
        style: TextStyle(
                color: Colors.lightGreen,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),),
      ),
      body: BlocBuilder<ApiSummaryCubit, ApiSummaryState>(
        builder: (context, state) {
          if (state is JsonSummaryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is JsonSummaryLoaded) {
            final averages = ApiSummaryCubit.get(context).averageValuesByDate;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Average Data by Date',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: averages.keys.length,
                      itemBuilder: (context, index) {
                        String date = averages.keys.elementAt(index);
                        var data = averages[date]!;

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  date,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text("Average Cadence (spm): ${data['Cadence']?.toStringAsFixed(2) ?? 'N/A'}"),
                                Text("Average Steps: ${data['Steps']?.toStringAsFixed(2) ?? 'N/A'}"),
                                Text("Average Distance(m): ${data['Distance']?.toStringAsFixed(2) ?? 'N/A'}"),
                                Text("Average Stride Length (m): ${data['Stride Length']?.toStringAsFixed(2) ?? 'N/A'}"),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is JsonSummaryError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
}
