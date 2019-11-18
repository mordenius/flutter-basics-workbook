import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectLocation;

  const LocationInput({Key key, this.onSelectLocation}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  Future<void> _getUserCurrentLocation() async {
    final locData = await Location().getLocation();
    print(locData.latitude);
    print(locData.longitude);
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
                onPressed: () {}),
          ],
        )
      ],
    );
  }
}
