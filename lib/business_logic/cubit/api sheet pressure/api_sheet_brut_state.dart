part of 'api_sheet_brut_cubit.dart';

abstract class ApiSheetBrutState {}

class ApiInitialBrut extends ApiSheetBrutState {}

class JsonLoadingBrut extends ApiSheetBrutState {}

class JsonLoadedBrut extends ApiSheetBrutState {
  final List<Map<String, dynamic>> fsrValues; // Changed to dynamic
  final List<String> time;

  JsonLoadedBrut(this.fsrValues, this.time);
}

class JsonErrorBrut extends ApiSheetBrutState {
  final String message;

  JsonErrorBrut(this.message);
}
