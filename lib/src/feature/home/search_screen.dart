import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nearby_restaurants/src/cubit/restaurant_cubit/restaurant_cubit.dart';
import 'package:nearby_restaurants/src/cubit/restaurant_cubit/restaurant_state.dart';
import 'package:nearby_restaurants/src/feature/home/restaurant_details.dart';

import '../../core/components/restaurant_components.dart';
import '../../core/constants/responsive.dart';
import '../../core/models/restaurant_model.dart';

class SearchScreen extends StatelessWidget {
  final List<Restaurant> result;
   SearchScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocConsumer<RestaurantCubit, RestaurantState>(
      builder: (BuildContext context, state) {
        var cubit = RestaurantCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.isDesktop(context) ? 4 : 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemCount: result.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return RestaurantDetails(
                        model: result[index],
                      );
                    }),
                  );
                },
                child:
                restaurantCard(theme, model: result[index]),
              );
            },
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
