import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nearby_restaurants/src/core/constants/responsive.dart';
import 'package:nearby_restaurants/src/theme/palette.dart';

import '../core/constants/constant.dart';

class CustomTheme {
  static ThemeData lightTheme(BuildContext context) {
    final theme = Theme.of(context);
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'Cairo',
      primaryColor: Palette.primaryColor,
      primarySwatch: MaterialColor(Palette.primaryColorShade500.value, const {
        100: Palette.primaryColorShade100,
        200: Palette.primaryColorShade200,
        300: Palette.primaryColorShade300,
        400: Palette.primaryColorShade400,
        500: Palette.primaryColorShade500,
        600: Palette.primaryColorShade600,
        700: Palette.primaryColorShade700,
        800: Palette.primaryColorShade800,
        900: Palette.primaryColorShade900,
      }),
      scaffoldBackgroundColor: Colors.grey.shade50,
      appBarTheme: AppBarTheme(
          elevation: 0.0,
          centerTitle: true,
          color: Palette.white,
          titleTextStyle: TextStyle(
            fontSize:Responsive.isDesktop(context) ? 15.sp: 40.sp,
            fontFamily: 'Cairo',
            color: Palette.primaryColorShade500,
          ),
          actionsIconTheme: const IconThemeData(size: 33),
          foregroundColor: Palette.primaryColor),
      textTheme: theme.primaryTextTheme
          .copyWith(
            labelLarge: theme.primaryTextTheme.labelLarge?.copyWith(
              color: Palette.black,
              fontSize: Responsive.isDesktop(context) ? 10.sp: 30.sp,
              fontWeight: FontWeight.bold,
            ),
            bodyLarge: const TextStyle(color: Palette.black700),
            headlineSmall: const TextStyle(color: Palette.black700),
          )
          .apply(displayColor: Palette.black, fontFamily: 'Cairo'),
      popupMenuTheme: const PopupMenuThemeData(iconColor: Palette.black700),
      iconTheme: const IconThemeData(color: Palette.primaryColor, size: 30),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Palette.primaryColorShade500,
        foregroundColor: Palette.white,
      ),
      bottomSheetTheme:
          const BottomSheetThemeData(backgroundColor: Palette.white),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Palette.primaryColorShade500,
        ),
      ),
      searchBarTheme: const SearchBarThemeData(
        elevation: WidgetStatePropertyAll(0.0),
        textStyle: WidgetStatePropertyAll(
          TextStyle(color: Colors.grey),
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: Palette.white,
        titleTextStyle: TextStyle(
            color: Palette.primaryColor,
            fontSize: 40.sp,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold),
        contentTextStyle: TextStyle(
            color: Palette.black700, fontFamily: 'Cairo', fontSize: 26.sp),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Palette.primaryColor,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Palette.primaryColor),
          borderRadius: BorderRadius.circular(kRadius / 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Palette.primaryColorShade300),
          borderRadius: BorderRadius.circular(kRadius/ 1.5),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Palette.primaryColorShade300),
          borderRadius: BorderRadius.circular(kRadius/ 1.5),
        ),
        labelStyle: const TextStyle(color: Palette.black700),
        hintStyle: const TextStyle(color: Palette.black700),
      ),
    );
  }
}
