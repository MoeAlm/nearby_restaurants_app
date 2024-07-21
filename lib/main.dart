import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nearby_restaurants/src/feature/home/home_screen.dart';
import 'package:nearby_restaurants/src/theme/custom_theme.dart';

import 'src/cubit/restaurant_cubit/restaurant_cubit.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => RestaurantCubit()..fetchRestaurants()),
  ], child: const NearbyApp()));
}

class NearbyApp extends StatelessWidget {
  const NearbyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(720, 1560),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Nearby App',
          theme: CustomTheme.lightTheme(context),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale("ar", ""),
          ],
          home: child,
        );
      },
      child: const HomeScreen(),
    );
  }
}
