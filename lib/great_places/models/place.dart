import 'dart:io';

import 'package:flutter/foundation.dart';

class PlaceLocation {
  final double lattitude;
  final double longitude;
  final String address;

  PlaceLocation(
      {@required this.lattitude, @required this.longitude, this.address});
}

class Place {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;

  Place({this.id, this.title, @required this.location, this.image});
}
