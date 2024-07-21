import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../theme/palette.dart';
import '../constants/constant.dart';

Widget ratingCard(ThemeData theme, {required double rate, required int count}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(kRadius),
      color: Palette.white,
    ),
    child: RichText(
      text: TextSpan(
        text: '⭐$rate ',
        style: theme.textTheme.bodyLarge,
        children: <TextSpan>[
          TextSpan(
            text: '($count+)',
            style: theme.textTheme.bodySmall!
                .copyWith(color: Colors.grey),
          ),
        ],
      ),
    ).pSymmetric(v: 1, h: 12),
  );
}
