import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_sheet_cadence_state.dart';

class ApiCadenceCubit extends Cubit<ApiSheetCadenceState> {
  ApiCadenceCubit() : super(ApiCadenceInitial());
  static ApiCadenceCubit get(context) => BlocProvider.of(context);

  int itemCount = 60;
  List<Map<String, dynamic>> cadenceData = [];
  List<String> time = [];

  Future<void> getCadenceJson() async {
    emit(JsonCadenceLoading());
    try {
      var url = Uri.parse(
          "https://script.google.com/macros/s/AKfycbxtPj38Myvty2XeSjybidHLgiPM8_DUody_4iUEjben4OHYFr8JRVrYBycOwNGrhHSq/exec");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        // Log the received data for debugging
        print("Data received: $data");

        if (data is List<dynamic>) {
          itemCount = data.length < 60 ? data.length : 60;

          // Filter out invalid entries and ensure proper typing
          cadenceData = data
              .where((item) => item['Cadence'] != null && item['Time'] != null)
              .map((item) => {
                    'Cadence': double.tryParse(item['Cadence'].toString()),
                    'Time': item['Time'].toString(),
                  })
              .toList();

          // Extract time labels separately
          time = cadenceData.map((item) => item['Time'] as String).toList();

          emit(JsonCadenceLoaded(cadenceData, time));
        } else {
          emit(JsonCadenceError("Error loading data: Data is not a list"));
        }
      } else {
        emit(JsonCadenceError("Error loading data: ${response.statusCode}"));
      }
    } catch (e) {
      emit(JsonCadenceError("Error loading data: $e"));
    }
  }
}
