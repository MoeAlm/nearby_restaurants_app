import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:nearby_restaurants/src/core/constants/responsive.dart';
import 'package:nearby_restaurants/src/core/helpers/assets_helper.dart';
import 'package:nearby_restaurants/src/cubit/restaurant_cubit/restaurant_cubit.dart';
import 'package:nearby_restaurants/src/cubit/restaurant_cubit/restaurant_state.dart';
import 'package:nearby_restaurants/src/feature/home/search_screen.dart';
import 'package:nearby_restaurants/src/theme/palette.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../core/components/restaurant_components.dart';
import 'restaurant_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocConsumer<RestaurantCubit, RestaurantState>(
      builder: (BuildContext context, state) {
        var cubit = RestaurantCubit.get(context);
        return ModalProgressHUD(
          inAsyncCall: cubit.isLoading,
          progressIndicator: const CircularProgressIndicator(color: Palette.primaryColor,),
          child: Scaffold(
            appBar: AppBar(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage(Assets.profileImage),
                  ),
                  Text(
                    'محمد المازوزي',
                    style: theme.textTheme.labelLarge,
                  ).pOnly(right: 8)
                ],
              ),
              actions: [
                Badge.count(
                  count: 0,
                  textColor: Palette.white,
                  child: const Icon(CupertinoIcons.bell),
                ).px12()
              ],
            ),
            body: FutureBuilder(
                future: cubit.fetchRestaurants(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      children: [
                        SizedBox(
                          height: 100.h,
                        ),
                        TextField(
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              suffixIcon: Icon(CupertinoIcons.search),
                              hintText: "ابحث عن اسم المطعم من هنا"),
                          onSubmitted: (query) {
                            cubit.changeState();
                            cubit.searchRestaurants(query).then((value) {
                              for (var element in value) {
                              }
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SearchScreen(result: value);
                              }));
                              cubit.changeState();
                              return null;
                            });
                          },
                        ),
                        Text(
                          'المطاعم القريبة منك',
                          style: theme.textTheme.headlineSmall,
                        ).py16(),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: Responsive.isDesktop(context) ? 4 : 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return RestaurantDetails(
                                      model: snapshot.data![index],
                                    );
                                  }),
                                );
                              },
                              child: restaurantCard(theme,
                                  model: snapshot.data![index]),
                            );
                          },
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Palette.primaryColor,
                      ),
                    );
                  }
                }),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
