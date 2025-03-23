import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:smartinsole/business_logic/cubit/api_sheet_stridelength/api_sheet_stridelength_cubit.dart';
import 'package:smartinsole/business_logic/cubit/api_sheet_summary/api_sheet_summary_cubit.dart';
import 'package:smartinsole/pages/authen.dart';
import 'package:smartinsole/routes/routes.dart';

import 'business_logic/cubit/api sheet analysed/api_sheet_cubit.dart';
import 'business_logic/cubit/api sheet pressure/api_sheet_brut_cubit.dart';
import 'business_logic/cubit/api_sheet_cadence/api_sheet_cadence_cubit.dart';
import 'business_logic/cubit/api_sheet_distance/api_sheet_distance_cubit.dart';
import 'business_logic/cubit/cubit activity user/activity_cubit.dart';

import 'business_logic/cubit/cubit foot pressure left/foot_pressure_left_cubit.dart';
import 'business_logic/cubit/cubit foot pressure/footpressure_cubit.dart';
import 'business_logic/cubit/cubit header trainer/header_trainer_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // web_options
    options: const FirebaseOptions(
      apiKey: '',
      appId: '',
      messagingSenderId: '',
      projectId: '',
      authDomain: '',
      storageBucket: '',
      databaseURL:
          'https://authentification-pfe-35b79-default-rtdb.europe-west1.firebasedatabase.app/',
    ),
  );

  final databaseReference = FirebaseDatabase.instance.ref();
  final databaseReference1 = FirebaseDatabase.instance.ref();

  runApp(MyApp(
      databaseReference: databaseReference,
      databaseReference1: databaseReference1));
}

class MyApp extends StatelessWidget {
  final DatabaseReference databaseReference;
  final DatabaseReference databaseReference1;

  const MyApp(
      {Key? key,
      required this.databaseReference,
      required this.databaseReference1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ActivityCubit()..fetchData()),
        BlocProvider(
            create: (context) =>
                InsoleCubit(databaseReference)..fetchFSRValues()),
        BlocProvider<ApiCubit>(create: (context) => ApiCubit()..getJson()),
        BlocProvider(create: (context) => ApiSheetBrutCubit()..getFsrValues()),
        BlocProvider<ApiCadenceCubit>(create: (context) => ApiCadenceCubit()),
        BlocProvider(create: (context) => HeaderTrainerCubit()),
        BlocProvider<ApiDistanceCubit>(create: (context) => ApiDistanceCubit()),
        BlocProvider<ApiStrideLengthCubit>(
            create: (context) => ApiStrideLengthCubit()),
        BlocProvider(create: (context) => ApiSummaryCubit()..getSummaryJson()),
        BlocProvider(
            create: (context) =>
                InsoleLeftCubit(databaseReference1)..fetchFSRLeftValues()),
      ],
      child: MaterialApp(
        title: 'Smart Insole',
        debugShowCheckedModeBanner: false,
        home: const AuthPage(),
        routes: getRoutes(),
      ),
    );
  }
}
