import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_sheet_stridelength_state.dart';

class ApiStrideLengthCubit extends Cubit<ApiSheetStrideLengthState> {
  ApiStrideLengthCubit() : super(ApiStrideLengthInitial());
  static ApiStrideLengthCubit get(context) => BlocProvider.of(context);

  int itemCount = 60;
  List<Map<String, dynamic>> strideLengthData = [];
  List<String> time = [];

  Future<void> getStrideLengthJson() async {
    emit(JsonStrideLengthLoading());
    try {
      var url = Uri.parse(
          "https://script.google.com/macros/s/AKfycbxtPj38Myvty2XeSjybidHLgiPM8_DUody_4iUEjben4OHYFr8JRVrYBycOwNGrhHSq/exec");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data is List<dynamic>) {
          itemCount = data.length < 60 ? data.length : 60;

          // Filter out invalid entries and ensure proper typing
          strideLengthData = data
              .where((item) =>
                  item['Stride Length'] != null && item['Time'] != null)
              .map((item) => {
                    'Stride Length':
                        double.tryParse(item['Stride Length'].toString()),
                    'Time': item['Time'].toString(),
                  })
              .toList();

          // Extract time labels separately
          time =
              strideLengthData.map((item) => item['Time'] as String).toList();

          emit(JsonStrideLengthLoaded(strideLengthData, time));
        } else {
          emit(JsonStrideLengthError("Error loading data: Data is not a list"));
        }
      } else {
        emit(JsonStrideLengthError(
            "Error loading data: ${response.statusCode}"));
      }
    } catch (e) {
      emit(JsonStrideLengthError("Error loading data: $e"));
    }
  }
}
