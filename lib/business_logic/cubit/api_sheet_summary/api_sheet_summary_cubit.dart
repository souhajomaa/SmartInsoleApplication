import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'api_sheet_summary_state.dart';

class ApiSummaryCubit extends Cubit<ApiSummaryState> {
  ApiSummaryCubit() : super(ApiSummaryInitial());
  static ApiSummaryCubit get(context) => BlocProvider.of(context);

  List<dynamic> sensorValues = [];
  Map<String, Map<String, double>> averageValuesByDate = {};

  Future getSummaryJson() async {
    emit(JsonSummaryLoading());

    try {
      var url = Uri.parse(
          "https://script.google.com/macros/s/AKfycbxtPj38Myvty2XeSjybidHLgiPM8_DUody_4iUEjben4OHYFr8JRVrYBycOwNGrhHSq/exec");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        sensorValues = jsonDecode(response.body);
        _filterAndCalculateAverages();
        emit(JsonSummaryLoaded(sensorValues));
      } else {
        emit(JsonSummaryError("Error loading data: ${response.statusCode}"));
      }
    } catch (e) {
      emit(JsonSummaryError("Error loading data: $e"));
    }
  }

  void _filterAndCalculateAverages() {
    Map<String, List<Map<String, double>>> groupedData = {};

    for (var entry in sensorValues) {
      // Filtrer les entrées avec des dates incorrectes ou des valeurs nulles
      if (entry['Date'] != null && entry['Cadence'] != null && entry['Steps'] != null &&
          entry['Distance'] != null && entry['Stride Length'] != null) {
        
        String date = entry['Date'];
        if (!groupedData.containsKey(date)) {
          groupedData[date] = [];
        }
        groupedData[date]!.add({
          'Cadence': _toDouble(entry['Cadence']),
          'Steps': _toDouble(entry['Steps']),
          'Distance': _toDouble(entry['Distance']),
          'Stride Length': _toDouble(entry['Stride Length']),
        });
      }
    }

    averageValuesByDate = groupedData.map((date, values) {
      int count = values.length;
      double totalCadence = values.fold(0, (sum, item) => sum + item['Cadence']!);
      double totalSteps = values.fold(0, (sum, item) => sum + item['Steps']!);
      double totalDistance = values.fold(0, (sum, item) => sum + item['Distance']!);
      double totalStrideLength = values.fold(0, (sum, item) => sum + item['Stride Length']!);

      return MapEntry(date, {
        'Cadence': totalCadence / count,
        'Steps': totalSteps / count,
        'Distance': totalDistance / count,
        'Stride Length': totalStrideLength / count,
      });
    });
  }

  double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    try {
      return double.parse(value.toString());
    } catch (e) {
      return 0.0;
    }
  }
}
