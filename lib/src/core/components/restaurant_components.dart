import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nearby_restaurants/src/core/components/rate_components.dart';
import 'package:nearby_restaurants/src/core/helpers/assets_helper.dart';
import 'package:nearby_restaurants/src/core/models/restaurant_model.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../theme/palette.dart';
import '../constants/constant.dart';

Widget restaurantCard(ThemeData theme, {required Restaurant model}) {
  return Hero(
    tag: model.photoUrl ?? '',
    child: Container(
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
          gradient: LinearGradient(
            colors: [
              Palette.black,
              Palette.black.withOpacity(0.6),
              Palette.black.withOpacity(0.3),
              Colors.transparent,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ratingCard(theme,
                rate: model.rating, count: model.userRatingsTotal),
            model.openNow ? SizedBox.shrink():
            Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(kRadius)
              ),
              child: Text('مغلق').pSymmetric(v: 2, h: 10),
            ).py12(),
            const Spacer(),
            Text(
              model.name,
              style: theme.textTheme.labelLarge!.copyWith(color: Palette.white),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ).py4(),
            Row(
              children: [
                Icon(
                  CupertinoIcons.location_solid,
                  size: 17,
                ),
                Text(
                  model.address,
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: Palette.white,
                  ),
                )
              ],
            )
          ],
        ).p(12),
      ),
    ),
  );
}
