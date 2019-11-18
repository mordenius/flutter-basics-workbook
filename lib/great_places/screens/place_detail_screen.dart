import 'package:flutter/material.dart';

import './../models/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  static final String routeName = '/great-places/place-detail';
  
  @override
  Widget build(BuildContext context) {
    final Place place = ModalRoute.of(context).settings.arguments; 
    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
    );
  }
}
