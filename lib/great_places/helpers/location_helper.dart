import 'dart:convert';

import 'package:http/http.dart';

const _GOOGLE_API_KEY = 'AIzaSyCU3JKviZ4mR0xv9YiVqgTsXbWm5zg0Kv0';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap' +
        '&markers=color:red%7Clabel:A%7C$latitude,$longitude' +
        '&key=$_GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress(
      {double latitude, double longitude}) async {
    Response response = await get(
        'https://maps.googleapis.com/maps/api/geocode/json?' +
            'latlng=$latitude,$longitude' +
            '&key=$_GOOGLE_API_KEY');

    if (response.statusCode >= 300) {
      return '';
    }

    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
