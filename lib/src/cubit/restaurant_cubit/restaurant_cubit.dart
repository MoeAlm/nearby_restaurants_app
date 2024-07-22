import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nearby_restaurants/src/core/constants/constant.dart';
import 'package:nearby_restaurants/src/core/helpers/api.dart';

import '../../core/models/restaurant_model.dart';
import 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  RestaurantCubit() : super(InitialState());

  static RestaurantCubit get(context) => BlocProvider.of(context);

  bool isLoading = false;

  void changeState() {
    isLoading = !isLoading;
    emit(ChangeState());
  }

  Future<List<Restaurant>> fetchNearbyRestaurants(
      double userLat, double userLng) async {
    final response = await ApiHelper().getApi(
      url:
          '$baseUrl/place/nearbysearch/json?location=$userLat,$userLng&radius=1500&type=restaurant&key=$googleApiKey',
    );

    if (response['status'] == 'OK') {
      List<dynamic> results = response['results'];
      List<Restaurant> restaurants = results.take(10).map((json) {
        return Restaurant.fromJson(json, userLat, userLng);
      }).toList();
      return restaurants;
    } else {
      throw Exception('Failed to load nearby restaurants');
    }
  }

  Future<List<Restaurant>> fetchRestaurants() async {
    try {
      Position position = await _determinePosition();
      List<Restaurant> restaurants = await fetchNearbyRestaurants(
        position.latitude,
        position.longitude,
      );

      return restaurants;
    } catch (e) {
      rethrow;
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<List<Restaurant>> searchRestaurants(String query) async {
    try {
      Position position = await _determinePosition();
      final String url =
          '$baseUrl/place/textsearch/json?query=$query&location=${position.latitude},${position.longitude}&radius=1500&type=restaurant&key=$googleApiKey';

      final response = await ApiHelper().getApi(url: url);

      if (response['status'] == 'OK') {
        List<dynamic> results = response['results'];
        List<Restaurant> restaurants = results.take(10).map((json) {
          return Restaurant.fromJson(
              json, position.latitude, position.longitude);
        }).toList();
        return restaurants;
      } else {
        throw Exception('Failed to search restaurants');
      }
    } catch (e) {
      rethrow;
    }
  }
}
