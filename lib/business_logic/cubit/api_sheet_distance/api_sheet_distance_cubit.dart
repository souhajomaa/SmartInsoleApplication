import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_sheet_distance_state.dart';

class ApiDistanceCubit extends Cubit<ApiSheetDistanceState> {
  ApiDistanceCubit() : super(ApiDistanceInitial());
  static ApiDistanceCubit get(context) => BlocProvider.of(context);

  int itemCount = 60;
  List<Map<String, dynamic>> distanceData = [];
  List<String> time = [];

  Future<void> getDistanceJson() async {
    emit(JsonDistanceLoading());
    try {
      var url = Uri.parse(
          "https://script.google.com/macros/s/AKfycbxtPj38Myvty2XeSjybidHLgiPM8_DUody_4iUEjben4OHYFr8JRVrYBycOwNGrhHSq/exec");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data is List<dynamic>) {
          itemCount = data.length < 60 ? data.length : 60;

          // Filter out invalid entries and ensure proper typing
          distanceData = data
              .where((item) => item['Distance'] != null && item['Time'] != null)
              .map((item) => {
                    'Distance': double.tryParse(item['Distance'].toString()),
                    'Time': item['Time'].toString(),
                  })
              .toList();

          // Extract time labels separately
          time = distanceData.map((item) => item['Time'] as String).toList();

          emit(JsonDistanceLoaded(distanceData, time));
        } else {
          emit(JsonDistanceError("Error loading data: Data is not a list"));
        }
      } else {
        emit(JsonDistanceError("Error loading data: ${response.statusCode}"));
      }
    } catch (e) {
      emit(JsonDistanceError("Error loading data: $e"));
    }
  }
}
