import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartinsole/presentation/dashboard/util/responsive.dart';
import 'package:smartinsole/presentation/dashboard/widgets/custom_card_widget.dart';

import '../../../business_logic/cubit/cubit activity user/activity_cubit.dart';
import '../../../business_logic/cubit/cubit activity user/activity_states.dart';

class ActivityDetailsCard extends StatelessWidget {
  const ActivityDetailsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivityCubit, ActivityState>(
      listener: (context, state) {
        if (state is ActivityError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is ActivityLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ActivityLoaded) {
          final data = state.data;
          return GridView.builder(
            itemCount: data.length,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
              crossAxisSpacing: Responsive.isMobile(context) ? 12 : 15,
              mainAxisSpacing: 12.0,
            ),
            itemBuilder: (context, index) {
              String title = data.keys.toList()[index];
              String value = data.values.toList()[index].toString();

              return CustomCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/${title.toLowerCase()}.png',
                      width: 50,
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 4),
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
