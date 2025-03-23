import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'api_sheet_brut_state.dart';

class ApiSheetBrutCubit extends Cubit<ApiSheetBrutState> {
  ApiSheetBrutCubit() : super(ApiInitialBrut());

  static ApiSheetBrutCubit get(context) => BlocProvider.of(context);

  int itemCount = 60;
  List<Map<String, dynamic>> fsrValues = [];
  List<String> time = [];

  Future<void> getFsrValues() async {
    emit(JsonLoadingBrut());
    try {
      var url = Uri.parse(
          "https://script.google.com/macros/s/AKfycbwpvvkcivmJHAJ9H8lRmQ6GkWt6kLLUtBrShHnfnCdeWFdzcD-vLALPKkHqxVQhiUM/exec");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        itemCount = data.length < 60 ? data.length : 60;

        fsrValues = [];
        time = [];

        for (var element in data) {
          Map<String, dynamic> fsrMap = {
            "FSR1": _parseFsrValue(element["FSR1"]),
            "FSR2": _parseFsrValue(element["FSR2"]),
            "FSR3": _parseFsrValue(element["FSR3"]),
            "FSR4": _parseFsrValue(element["FSR4"]),
            "FSR5": _parseFsrValue(element["FSR5"]),
            "FSR6": _parseFsrValue(element["FSR6"]),
            "FSR7": _parseFsrValue(element["FSR7"]),
            "FSR8": _parseFsrValue(element["FSR8"]),
          };

          fsrValues.add(fsrMap);
          time.add(element['Time'] ?? '00:00:00');
        }
        print("FSR Values: $fsrValues"); // Log the values to the console
        print("Times: $time"); // Log the times to the console
        emit(JsonLoadedBrut(fsrValues, time));
      } else {
        emit(JsonErrorBrut("Error loading data: ${response.statusCode}"));
      }
    } catch (e) {
      emit(JsonErrorBrut("Error loading data: $e"));
    }
  }

  double _parseFsrValue(dynamic value) {
    try {
      return double.parse(value.toString().replaceAll(',', '.'));
    } catch (e) {
      return 0.0;
    }
  }
}
