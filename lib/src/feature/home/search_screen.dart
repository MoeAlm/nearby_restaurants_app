import 'package:flutter/material.dart';

import 'package:nearby_restaurants/src/feature/home/restaurant_details.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../core/components/restaurant_components.dart';
import '../../core/constants/responsive.dart';
import '../../core/models/restaurant_model.dart';

class SearchScreen extends StatelessWidget {
  final List<Restaurant> result;
   const SearchScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return   Scaffold(
      appBar: AppBar(),
      body: GridView.builder(
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
      ).p12(),
    );
  }
}
