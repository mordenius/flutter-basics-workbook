import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import './../helpers/location_helper.dart';
import './../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function({double latitude, double longitude}) onSelectLocation;

  const LocationInput({Key key, this.onSelectLocation}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  void _showPreviewForSelected({double latitude, double longitude}) {
    setState(() {
      _previewImageUrl = LocationHelper.generateLocationPreviewImage(
          latitude: latitude, longitude: longitude);
    });

    widget.onSelectLocation(latitude: latitude, longitude: longitude);
  }

  Future<void> _getUserCurrentLocation() async {
    final locData = await Location().getLocation();

    if (locData == null) {
      return;
    }

    _showPreviewForSelected(
      latitude: locData.latitude,
      longitude: locData.longitude,
    );
  }

  Future<void> _selectOnMap() async {
    final selectLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) {
          return MapScreen(
            isSelecting: true,
          );
        },
      ),
    );

    if (selectLocation == null) {
      return;
    }

    _showPreviewForSelected(
      latitude: selectLocation.latitude,
      longitude: selectLocation.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? Text('No location chosen')
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FlatButton.icon(
                icon: Icon(Icons.location_on),
                label: Text('Current Location'),
                textColor: Theme.of(context).primaryColor,
                onPressed: _getUserCurrentLocation),
            FlatButton.icon(
                icon: Icon(Icons.map),
                label: Text('Select on Map'),
                textColor: Theme.of(context).primaryColor,
                onPressed: _selectOnMap),
          ],
        )
      ],
    );
  }
}
