import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
part 'api_sheet_state.dart';

class ApiCubit extends Cubit<ApiState> {
  ApiCubit() : super(ApiInitial());
  static ApiCubit get(context) => BlocProvider.of(context);
  List<dynamic> sensorValues = [];
  String json = '';
  Future getJson() async {
    emit(JsonLoading());

    try {
      var url = Uri.parse(
          "https://script.google.com/macros/s/AKfycbxtPj38Myvty2XeSjybidHLgiPM8_DUody_4iUEjben4OHYFr8JRVrYBycOwNGrhHSq/exec");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        sensorValues = jsonDecode(response.body);
        
        emit(JsonLoaded(sensorValues));
        return response;
      } else {
        emit(JsonError("Error loading data: ${response.statusCode}"));
      }
    } catch (e) {
      emit(JsonError("Error loading data: $e"));
    }
  }
}
