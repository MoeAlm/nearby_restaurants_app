import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nearby_restaurants/src/core/constants/constant.dart';
import 'package:nearby_restaurants/src/core/constants/responsive.dart';
import 'package:nearby_restaurants/src/core/helpers/assets_helper.dart';
import 'package:nearby_restaurants/src/core/models/restaurant_model.dart';
import 'package:nearby_restaurants/src/theme/palette.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../core/components/rate_components.dart';

class RestaurantDetails extends StatelessWidget {
  final Restaurant model;
  const RestaurantDetails({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل المطعم'),
      ),
      body: ListView(
        children: [
          Hero(
            tag: model.photoUrl ?? '',
            child: Container(
              width: double.infinity,
              height: Responsive.isDesktop(context) ? 600.h : 300.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kRadius),
                image: model.photoUrl == null
                    ? const DecorationImage(
                    image: AssetImage(Assets.restaurantImage), fit: BoxFit.cover)
                    : DecorationImage(
                    image: NetworkImage(model.photoUrl!), fit: BoxFit.cover),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kRadius),
                  gradient: const LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                      Palette.black
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ratingCard(theme, rate: model.rating, count: model.userRatingsTotal),
                    model.openNow ? SizedBox.shrink():
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(kRadius)
                      ),
                      child: Text('مغلق').pSymmetric(v: 2, h: 10),
                    ).py12(),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.location_solid,
                              size: 25,
                            ),
                            Text(
                              model.address,
                              style: theme.textTheme.bodySmall!.copyWith(
                                  color: Palette.white,
                                  fontSize: Responsive.isDesktop(context)
                                      ? 15.sp
                                      : 30.sp),
                            ).px8()
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delivery_dining,
                              size: 25,
                            ),
                            Text(
                              '${model.distanceFromUser?.toStringAsFixed(2)} كم',
                              style: theme.textTheme.bodySmall!.copyWith(
                                  color: Palette.white,
                                  fontSize: Responsive.isDesktop(context)
                                      ? 15.sp
                                      : 30.sp),
                            ).px8()
                          ],
                        ),
                      ],
                    )
                  ],
                ).p(12),
              ),
            ),
          ),
          Text(
            model.name,
            style: theme.textTheme.headlineMedium!.copyWith(
                color: Palette.black700,
                fontWeight: FontWeight.w500,
                fontSize: Responsive.isDesktop(context) ? 20.sp : 50.sp),
          ).py12(),
          Divider(
            color: Palette.black700,
          ),
          Text(
            'أبجد هوز حطي كلمن سعفص قرشت ثخذ ضظغ'
            ' أبجد هوز حطي كلمن سعفص قرشت ثخذ ضظغ'
            ' أبجد هوز حطي كلمن سعفص قرشت ثخذ ضظغ'
            ' أبجد هوز حطي كلمن سعفص قرشت ثخذ ضظغ'
            ' أبجد هوز حطي كلمن سعفص قرشت ثخذ ضظغ',
            style: theme.textTheme.headlineMedium!.copyWith(
                color: Palette.black700,
                fontWeight: FontWeight.w500,
                fontSize: Responsive.isDesktop(context) ? 15.sp : 30.sp),
          ).py12(),
          const Divider(
            color: Palette.black700,
          ),
        ],
      ).px12(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          model.launchMap();
        },
        label: Text('العرض على الخريطة'),
        icon: Icon(CupertinoIcons.map),
      ),
    );
  }
}
