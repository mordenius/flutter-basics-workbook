import 'package:location/location.dart';

const _GOOGLE_API_KEY = '';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap' +
        '&markers=color:indigo%7Clabel:A%$latitude,$longitude' +
        '&key=$_GOOGLE_API_KEY';
  }
}
