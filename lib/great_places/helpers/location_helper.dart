import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter_config/flutter_config.dart';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    final String googleApiKey = FlutterConfig.get('GOOGLE_API_KEY');
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap' +
        '&markers=color:red%7Clabel:A%7C$latitude,$longitude' +
        '&key=$googleApiKey';
  }

  static Future<String> getPlaceAddress(
      {double latitude, double longitude}) async {
    final String googleApiKey = FlutterConfig.get('GOOGLE_API_KEY');
    Response response = await get(
        'https://maps.googleapis.com/maps/api/geocode/json?' +
            'latlng=$latitude,$longitude' +
            '&key=$googleApiKey');

    if (response.statusCode >= 300) {
      return '';
    }

    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
