import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../business_logic/cubit/cubit foot pressure left/foot_pressure_left_cubit.dart';
import '../../../business_logic/cubit/cubit foot pressure left/foot_pressure_left_state.dart';

class InsoleLeftGrid extends StatefulWidget {
  const InsoleLeftGrid({super.key});

  @override
  State<InsoleLeftGrid> createState() => _InsoleLeftGridState();
}

class _InsoleLeftGridState extends State<InsoleLeftGrid> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InsoleLeftCubit, InsoleLeftState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is InsoleLeftInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is InsoleLeftLoaded) {
          return buildInsoleGrid(context, state.fsrLeftValues);
        } else {
          return const Center(child: Text('Failed to load FSR values'));
        }
      },
    );
  }

  Widget buildInsoleGrid(BuildContext context, List<int> fsrValues) {
    final cubit = context.read<InsoleLeftCubit>();

    return Center(
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned(
            child: Opacity(
              opacity: 0.8,
              child: SizedBox(
                width: 200,
                height: 600,
                child: SvgPicture.asset(
                  'assets/images/pieds gauche.svg', // Chemin vers votre fichier SVG
                  width: 100,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            width: 200,
            height: 600,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 0.8,
              crossAxisSpacing: 0.8,
              children: List.generate(27, (index) {
                if (index == 5) {
                  final pressure = fsrValues[0];
                  return buildBlock(9, pressure, cubit);
                } else if (index == 8) {
                  final pressure = fsrValues[1];
                  return buildBlock(10, pressure, cubit);
                } else if (index == 7) {
                  final pressure = fsrValues[2];
                  return buildBlock(11, pressure, cubit);
                } else if (index == 9) {
                  final pressure = fsrValues[3];
                  return buildBlock(12, pressure, cubit);
                } else if (index == 12) {
                  final pressure = fsrValues[4];
                  return buildBlock(13, pressure, cubit);
                } else if (index == 19) {
                  final pressure = fsrValues[5];
                  return buildBlock(14, pressure, cubit);
                } else if (index == 18) {
                  final pressure = fsrValues[6];
                  return buildBlock(15, pressure, cubit);
                } else if (index == 22) {
                  final pressure = fsrValues[7];
                  return buildBlock(16, pressure, cubit);
                } else {
                  return const SizedBox(); // placeholder for unused grid cells
                }
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBlock(int number, int pressure, InsoleLeftCubit cubit) {
    return Container(
      decoration: BoxDecoration(
        color: cubit.getColorFromPressure(pressure),
        border: Border.all(color: Colors.black),
        borderRadius: getBorderRadius(number),
      ),
      child: Center(
        child: Text(
          '$number',
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  BorderRadius getBorderRadius(int number) {
    return const BorderRadius.all(Radius.circular(300));
  }
}
