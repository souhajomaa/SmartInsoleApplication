import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smartinsole/business_logic/cubit/cubit%20header%20trainer/header_trainer_cubit.dart';
import 'package:smartinsole/presentation/dashboard/util/responsive.dart';
import 'package:smartinsole/presentation/dashboard/widgets/custom_card_widget.dart';

import 'dart:async';

import '../../../business_logic/cubit/cubit header trainer/header_trainer_state.dart';

class HeaderWidget extends StatelessWidget {
  final String email; // Ajoutez l'email de l'utilisateur connecté

  const HeaderWidget({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HeaderTrainerCubit()..getUsername(email),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!Responsive.isDesktop(context))
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.menu,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
              ),
            ),
          Expanded(
            child: CustomCard(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocBuilder<HeaderTrainerCubit, HeaderTrainerState>(
                      builder: (context, state) {
                        if (state is HeaderTrainerLoading) {
                          return const CircularProgressIndicator();
                        } else if (state is HeaderTrainerLoaded) {
                          return Text(
                            state.username,
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                          );
                        } else if (state is HeaderTrainerError) {
                          return Text(
                            'Error: ${state.message}',
                            style: const TextStyle(color: Colors.red, fontSize: 16),
                          );
                        } else {
                          return const Text(
                            'Trainer',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          );
                        }
                      },
                    ),
                    const SizedBox(width: 50),
                    StreamBuilder<String>(
                      stream: getCurrentDateTimeStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.active) {
                          return Text(
                            snapshot.data ?? '',
                            style: const TextStyle(
                                color: Color.fromARGB(255, 53, 156, 108), fontSize: 14),
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (Responsive.isMobile(context))
            InkWell(
              onTap: () => Scaffold.of(context).openEndDrawer(),
              child: const CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.chat,
                  color: Colors.black,
                  size: 32,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

Stream<String> getCurrentDateTimeStream() async* {
  while (true) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    yield formatter.format(now);
    await Future.delayed(const Duration(seconds: 1));
  }
}
