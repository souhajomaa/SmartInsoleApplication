import 'package:flutter/material.dart';
import 'package:smartinsole/presentation/dashboard/screen/Historyplayer/historytable.dart';
import 'package:smartinsole/presentation/dashboard/screen/Addplayer/summary_details.dart';

import '../../../../business_logic/cubit/api sheet analysed/api_sheet_cubit.dart';

class HistoryPlayer extends StatefulWidget {
  const HistoryPlayer({super.key});

  @override
  State<HistoryPlayer> createState() => _HistoryPlayerState();
}

class _HistoryPlayerState extends State<HistoryPlayer> {
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
              'Add',
              style: TextStyle(
                color: Colors.cyan,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Text(
              'History',
              style: TextStyle(
                color: Colors.lightGreen,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            SizedBox(height: 18),
            SummaryDetails(),
            SizedBox(height: 18),
            HistoryTable(),
          ],
        ),
      ),
    );
  }
}
