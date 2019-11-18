import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import './../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  const MapScreen(
      {Key key,
      this.initialLocation =
          const PlaceLocation(lattitude: 37.422, longitude: -122.084),
      this.isSelecting = false})
      : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _selectedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _selectedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        actions: widget.isSelecting
            ? <Widget>[
                IconButton(
                  icon: Icon(Icons.save),
                  onPressed: _selectedLocation == null
                      ? null
                      : () {
                          Navigator.of(context).pop(_selectedLocation);
                        },
                ),
              ]
            : null,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialLocation.lattitude,
              widget.initialLocation.longitude),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: _selectedLocation == null && widget.isSelecting
            ? null
            : {
                Marker(
                  markerId: MarkerId('A'),
                  position: _selectedLocation ??
                      LatLng(widget.initialLocation.lattitude,
                          widget.initialLocation.longitude),
                )
              },
      ),
    );
  }
}
