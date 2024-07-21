import 'package:map_launcher/map_launcher.dart';
import 'package:nearby_restaurants/src/core/constants/constant.dart';

import '../helpers/distance.dart';

class Restaurant {
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String? photoUrl;
  final double rating;
  final int userRatingsTotal;
  final bool openNow;
  final List<String> types;
  double? distanceFromUser;

  Restaurant({
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.photoUrl,
    required this.rating,
    required this.userRatingsTotal,
    required this.openNow,
    required this.types,
    this.distanceFromUser,
  });

  factory Restaurant.fromJson(
      Map<String, dynamic> json, double userLat, double userLng) {
    String? getPhotoUrl() {
      if (json['photos'] != null && json['photos'].isNotEmpty) {
        final photoReference = json['photos'][0]['photo_reference'];
        return '$baseUrl/place/photo?maxwidth=400&photoreference=$photoReference&key=$googleApiKey';
      }
      return null;
    }

    bool isOpenNow() {
      if (json['opening_hours'] != null &&
          json['opening_hours']['open_now'] != null) {
        return json['opening_hours']['open_now'];
      }
      return false;
    }

    double distance = DistanceCalculator.calculateDistance(
      userLat,
      userLng,
      json['geometry']['location']['lat'],
      json['geometry']['location']['lng'],
    );
    int roundUserRatingsTotal(int ratings) {
      return (ratings / 10).round() * 10;
    }

    return Restaurant(
      name: json['name'],
      address: truncateAddress(json['vicinity']),
      latitude: json['geometry']['location']['lat'],
      longitude: json['geometry']['location']['lng'],
      photoUrl: getPhotoUrl(),
      rating: json['rating']?.toDouble() ?? 0.0,
      userRatingsTotal: roundUserRatingsTotal(json['user_ratings_total'] ?? 0),
      openNow: isOpenNow(),
      types: List<String>.from(json['types']),
      distanceFromUser: distance,
    );
  }

  static String truncateAddress(String address) {
    List<String> words = address.split(' ');
    int length = 0;
    List<String> truncatedWords = [];

    for (String word in words) {
      if (length + word.length <= 20) {
        truncatedWords.add(word);
        length += word.length + 1;
      } else {
        break;
      }
    }

    return truncatedWords.join(' ') +
        (truncatedWords.length < words.length ? '...' : '');
  }

  void launchMap() async {
    final availableMaps = await MapLauncher.installedMaps;
    if (availableMaps.isNotEmpty) {
      await availableMaps.first.showMarker(
        coords: Coords(latitude, longitude),
        title: name,
        description: address,
      );
    } else {
      throw Exception('No map applications installed on this device.');
    }
  }
}
