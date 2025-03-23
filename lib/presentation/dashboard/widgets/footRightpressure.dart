import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../business_logic/cubit/cubit foot pressure/footpressure_cubit.dart';
import '../../../business_logic/cubit/cubit foot pressure/footpressure_state.dart';

class InsoleGrid extends StatefulWidget {
  const InsoleGrid({Key? key}) : super(key: key);

  @override
  State<InsoleGrid> createState() => _InsoleGridState();
}

class _InsoleGridState extends State<InsoleGrid> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InsoleCubit, InsoleState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is InsoleInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is InsoleLoaded) {
          return buildInsoleGrid(context, state.fsrValues);
        } else {
          return const Center(child: Text('Failed to load FSR values'));
        }
      },
    );
  }

  Widget buildInsoleGrid(BuildContext context, List<double> fsrValues) {
    final cubit = context.read<InsoleCubit>();

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
                  'assets/images/pieds droit.svg', // Chemin vers votre fichier SVG
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
                if (index == 3) {
                  final pressure = (fsrValues[0]);
                  return buildBlock(1, pressure, cubit);
                } else if (index == 6) {
                  final pressure = (fsrValues[1]);
                  return buildBlock(2, pressure, cubit);
                } else if (index == 7) {
                  final pressure = (fsrValues[2]);
                  return buildBlock(3, pressure, cubit);
                } else if (index == 11) {
                  final pressure = (fsrValues[3]);
                  return buildBlock(4, pressure, cubit);
                } else if (index == 14) {
                  final pressure = (fsrValues[4]);
                  return buildBlock(5, pressure, cubit);
                } else if (index == 19) {
                  final pressure = (fsrValues[5]);
                  return buildBlock(6, pressure, cubit);
                } else if (index == 20) {
                  final pressure = (fsrValues[6]);
                  return buildBlock(7, pressure, cubit);
                } else if (index == 22) {
                  final pressure = (fsrValues[7]);
                  return buildBlock(8, pressure, cubit);
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

  Widget buildBlock(int number, double pressure, InsoleCubit cubit) {
    return Container(
      decoration: BoxDecoration(
        color: cubit.getColorFromPressure(pressure),
        border: Border.all(color: Colors.black),
        borderRadius: getBorderRadius(number),
      ),
      child: Center(
        child: Text(
          '$number',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  BorderRadius getBorderRadius(int number) {
    return const BorderRadius.all(Radius.circular(205));
  }
}
